#!/bin/bash
# Launcher for bind f. $1 is the invoking pane's current path, passed in
# from tmux.conf via #{pane_current_path}.
dir="$1"
primary=$(~/.config/programs/shell_scripts/caelestia-color.sh primary)
tmux display-popup -E -w 90% -h 80% -S "fg=$primary" -d "$dir" \
  ~/.config/programs/shell_scripts/tmux-popup-switcher-picker.sh
