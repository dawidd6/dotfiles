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

SESSIONS_FORMAT = {
    "session_name": "#{session_name}",
    "session_windows": "#{session_windows}",
    "windows": [],
}

WINDOWS_FORMAT = {
    "window_index": "#{window_index}",
    "window_name": "#{window_name}",
    "window_layout": "#{window_layout}",
    "window_panes": "#{window_panes}",
    "window_width": "#{window_width}",
    "window_height": "#{window_height}",
    "panes": [],
}

PANES_FORMAT = {
    "pane_index": "#{pane_index}",
    "pane_current_path": "#{pane_current_path}",
    "pane_current_command": "#{pane_current_command}",
    "command": "#{@rr-command}",
}


def clear():
    STATE_FILE.unlink(missing_ok=True)


def save():
    state = {
        "sessions": [
            json.loads(session)
            for session in subprocess.check_output(
                ["tmux", "list-sessions", "-F", json.dumps(SESSIONS_FORMAT)],
                text=True,
            ).splitlines()
        ],
    }
    for session_state in state["sessions"]:
        session_state["windows"] = [
            json.loads(window)
            for window in subprocess.check_output(
                [
                    "tmux",
                    "list-windows",
                    "-t",
                    f"={session_state['session_name']}",
                    "-F",
                    json.dumps(WINDOWS_FORMAT),
                ],
                text=True,
            ).splitlines()
        ]
        for window_state in session_state["windows"]:
            window_state["panes"] = [
                json.loads(pane)
                for pane in subprocess.check_output(
                    [
                        "tmux",
                        "list-panes",
                        "-t",
                        f"={session_state['session_name']}:{window_state['window_index']}",
                        "-F",
                        json.dumps(PANES_FORMAT),
                    ],
                    text=True,
                ).splitlines()
            ]
            for pane_state in window_state["panes"]:
                pane_state["scrollback"] = base64.b64encode(
                    subprocess.check_output(
                        [
                            "tmux",
                            "capture-pane",
                            "-t",
                            f"={session_state['session_name']}:{window_state['window_index']}.{pane_state['pane_index']}",
                            "-epJ",
                            "-S",
                            "0",
                        ]
                    )
                ).decode()
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
                    pane_state["pane_id"] = subprocess.check_output(
                        [
                            "tmux",
                            "new-session",
                            "-dPF",
                            "#{pane_id}",
                            window_state["window_width"],
                            "-y",
                            window_state["window_height"],
                            "-s",
                            session_state["session_name"],
                            "-n",
                            window_state["window_name"],
                            "-c",
                            pane_state["pane_current_path"],
                            "sleep",
                            "infinity",
                        ],
                        text=True,
                    ).strip()
                else:
                    pane_state["pane_id"] = subprocess.check_output(
                        [
                            "tmux",
                            "new-window",
                            "-dPF",
                            "#{pane_id}",
                            "-t",
                            f"={session_state['session_name']}",
                            "-n",
                            window_state["window_name"],
                            "-c",
                            pane_state["pane_current_path"],
                            "sleep",
                            "infinity",
                        ],
                        text=True,
                    ).strip()
            for pane_state in window_state["panes"][1:]:
                pane_state["pane_id"] = subprocess.check_output(
                    [
                        "tmux",
                        "split-window",
                        "-dPF",
                        "#{pane_id}",
                        "-t",
                        f"={session_state['session_name']}:{{end}}",
                        "-c",
                        pane_state["pane_current_path"],
                        "sleep",
                        "infinity",
                    ],
                    text=True,
                ).strip()
                subprocess.check_call(
                    [
                        "tmux",
                        "resize-pane",
                        "-t",
                        pane_state["pane_id"],
                        "-U",
                        "999",
                    ]
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
            for pane_state in window_state["panes"]:
                subprocess.check_call(
                    [
                        "tmux",
                        "respawn-pane",
                        "-k",
                        "-t",
                        pane_state["pane_id"],
                        "-c",
                        pane_state["pane_current_path"],
                        "sh",
                        "-c",
                        'tmux wait-for tmux-rr; exec "$SHELL" -li',
                    ]
                )
                Path(
                    subprocess.check_output(
                        [
                            "tmux",
                            "display-message",
                            "-pt",
                            pane_state["pane_id"],
                            "#{pane_tty}",
                        ],
                        text=True,
                    ).strip()
                ).write_bytes(base64.b64decode(pane_state["scrollback"], validate=True))
                subprocess.check_call(["tmux", "wait-for", "-S", "tmux-rr"])


def help():
    print(
        textwrap.dedent("""\
    Usage: tmux-rr <COMMAND>

    Commands:
      clear     TODO
      save      TODO
      restore   TODO
    """).strip()
    )
    exit(1)


if __name__ == "__main__":
    match len(sys.argv):
        case 2:
            match sys.argv[1]:
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
