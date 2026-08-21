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
    "panes": [],
}

PANES_FORMAT = {
    "pane_id": "#{pane_id}",
    "pane_index": "#{pane_index}",
    "pane_current_path": "#{pane_current_path}",
    "pane_current_command": "#{pane_current_command}",
    "pane_width": "#{pane_width}",
    "pane_height": "#{pane_height}",
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
        "scrollbacks": {},
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
                state["scrollbacks"][pane_state["pane_id"]] = base64.b64encode(
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


def replay(pane_id):
    scrollback = json.loads(STATE_FILE.read_text(encoding="utf-8"))["scrollbacks"][pane_id]  # fmt: skip
    sys.stdout.buffer.write(base64.b64decode(scrollback, validate=True))


def restore():
    def command(pane_id):
        return ["sh", "-c", f"'{sys.argv[0]}' replay '{pane_id}'; exec \"$SHELL\" -li"]

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
                        ]
                        + command(pane_state["pane_id"]),
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
                        ]
                        + command(pane_state["pane_id"]),
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
                    ]
                    + command(pane_state["pane_id"]),
                )
                subprocess.check_call(
                    [
                        "tmux",
                        "resize-pane",
                        "-t",
                        f"={session_state['session_name']}:{{end}}",
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
        case 1:
            help()
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
        case 3:
            match sys.argv[1]:
                case "replay":
                    replay(sys.argv[2])
        case _:
            help()
