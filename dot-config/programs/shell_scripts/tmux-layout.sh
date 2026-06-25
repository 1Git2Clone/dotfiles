#!/bin/bash

set -euo pipefail

SESSION="${SESSION:-${1:-"code"}}"

tmux new-session -d -s "$SESSION"

# Your steps:
tmux split-window -h      # mod %
tmux split-window -h      # mod %
tmux select-layout even-h # mod E

tmux select-pane -t 0 # go to first one
tmux split-window -v  # mod "

tmux select-pane -t 4     # go to last one
tmux split-window -v      # mod "
tmux split-window -v      # mod "
tmux select-layout even-v # mod E (applies to the active column)

# Attach to the session
tmux attach-session -t "$SESSION"
