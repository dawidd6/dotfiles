#!/usr/bin/env bash

set -euo pipefail

systemctl --user daemon-reload
systemctl --user enable --now fish-extra-completions.path
