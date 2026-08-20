#!/usr/bin/env python3

import base64
import json
import os
import subprocess
import sys
import textwrap
from pathlib import Path

STATE_FILE = (
    Path(os.environ.get("XDG_STATE_HOME") or Path.home() / ".local/state")
    / "tmux-rr.json"
)


def clear():
    STATE_FILE.unlink(missing_ok=True)


def save():
    state = {
        "sessions": [
            json.loads(session)
            for session in subprocess.check_output(
                [
                    "tmux",
                    "list-sessions",
                    "-F",
                    '{"session_name": "#{session_name}", "session_windows": #{session_windows}, "windows": []}',
                ],
                text=True,
            ).splitlines()
        ]
    }
    for session in state["sessions"]:
        session["windows"] = [
            json.loads(window)
            for window in subprocess.check_output(
                [
                    "tmux",
                    "list-windows",
                    "-t",
                    f"={state['sessions'][-1]['session_name']}",
                    "-F",
                    '{"window_index": #{window_index}, "window_name": "#{window_name}", "window_layout": "#{window_layout}", "window_panes": {window_panes}, "panes": []}',
                ],
                text=True,
            ).splitlines()
        ]
        for window in session["windows"]:
            panes = subprocess.check_output(
                [
                    "tmux",
                    "list-panes",
                    "-t",
                    f"={session_state['session_name']}:{window_state['window_index']}",
                    "-F",
                    "#{pane_index}\t#{pane_current_path}\t#{pane_current_command}\t#{pane_width}\t#{pane_height}\t#{@rr-command}",
                ],
                text=True,
            ).splitlines()
            session_state["windows"].append(window_state)
            for pane in panes:
                (
                    pane_index,
                    pane_current_path,
                    pane_current_command,
                    pane_width,
                    pane_height,
                    command,
                ) = pane.split("\t")
                scrollback = base64.b64encode(
                    subprocess.check_output(
                        [
                            "tmux",
                            "capture-pane",
                            "-t",
                            f"={session_state['session_name']}:{window_state['window_index']}.{pane_index}",
                            "-epJ",
                            "-S",
                            "0",
                        ]
                    )
                ).decode()
                pane_state = {
                    "pane_index": pane_index,
                    "pane_current_path": pane_current_path,
                    "pane_current_command": pane_current_command,
                    "pane_width": pane_width,
                    "pane_height": pane_height,
                    "command": command,
                    "scrollback": scrollback,
                }
                window_state["panes"].append(pane_state)
    STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
    STATE_FILE.touch(mode=0o600, exist_ok=True)
    STATE_FILE.chmod(0o600)
    STATE_FILE.write_text(json.dumps(state, indent=2), encoding="utf-8")


def restore():
    state = json.loads(STATE_FILE.read_text(encoding="utf-8"))
    for session_state in state["sessions"]:
        for window_state in session_state["windows"]:
            for pane_state in window_state["panes"][:1]:
                if (
                    subprocess.call(
                        [
                            "tmux",
                            "has-session",
                            "-t",
                            f"={session_state['session_name']}",
                        ]
                    )
                    > 0
                ):
                    subprocess.check_output(
                        [
                            "tmux",
                            "new-session",
                            "-d",
                            "-s",
                            session_state["session_name"],
                            "-n",
                            window_state["window_name"],
                            "-c",
                            pane_state["pane_current_path"],
                            "sh",
                            "-c",
                            "tmux wait-for tmux-rr; exec $SHELL -li",
                        ],
                    )
                else:
                    subprocess.check_call(
                        [
                            "tmux",
                            "new-window",
                            "-d",
                            "-t",
                            f"={session_state['session_name']}",
                            "-n",
                            window_state["window_name"],
                            "-c",
                            pane_state["pane_current_path"],
                            "sh",
                            "-c",
                            "tmux wait-for tmux-rr; exec $SHELL -li",
                        ],
                    )
            for pane_state in window_state["panes"][1:]:
                subprocess.check_call(
                    [
                        "tmux",
                        "split-window",
                        "-d",
                        "-t",
                        f"={session_state['session_name']}:{{end}}",
                        "-c",
                        pane_state["pane_current_path"],
                        "sh",
                        "-c",
                        "tmux wait-for tmux-rr; exec $SHELL -li",
                    ],
                )
            subprocess.check_call(
                [
                    "tmux",
                    "select-layout",
                    "-t",
                    f"={session_state['session_name']}:{{end}}",
                    window_state["window_layout"],
                ]
            )
            for pane_state, pane_tty in zip(
                window_state["panes"],
                subprocess.check_output(
                    [
                        "tmux",
                        "list-panes",
                        "-t",
                        f"={session_state['session_name']}:{{end}}",
                        "-F",
                        "#{pane_tty}",
                    ],
                    text=True,
                ).splitlines(),
                strict=True,
            ):
                subprocess.check_call(
                    [
                        "stty",
                        "-F",
                        pane_tty,
                        "cols",
                        pane_state["pane_width"],
                        "rows",
                        pane_state["pane_height"],
                    ]
                )
                Path(pane_tty).write_bytes(
                    base64.b64decode(pane_state["scrollback"], validate=True)
                )
            subprocess.check_call(["tmux", "wait-for", "-S", "tmux-rr"])


def help():
    print(
        textwrap.dedent("""\
    Usage: tmux-rr <COMMAND>

    Commands:
      save     TODO
      restore  TODO
    """).strip()
    )
    exit(1)


if __name__ == "__main__":
    match len(sys.argv):
        case 1:
            help()
        case 2:
            match sys.argv[-1]:
                case "clear":
                    clear()
                case "save":
                    save()
                case "restore":
                    restore()
                case _:
                    help()
        case _:
            help()
