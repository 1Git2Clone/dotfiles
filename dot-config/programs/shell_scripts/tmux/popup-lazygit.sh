#!/bin/bash
# Launcher for bind g. $1 is the invoking pane's current path, passed in
# from tmux.conf via #{pane_current_path} since this script has no other
# way to know which pane triggered it.
dir="$1"
primary=$(~/.config/programs/shell_scripts/caelestia-color.sh primary)
tmux display-popup -E -w 90% -h 90% -S "fg=$primary" -d "$dir" lazygit
