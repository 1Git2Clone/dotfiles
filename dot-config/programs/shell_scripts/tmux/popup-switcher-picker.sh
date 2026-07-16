#!/bin/bash
# fzf body for the session/window switcher popup (bind f). Colours are
# re-read from the live Caelestia scheme on every launch.
CC=~/.config/programs/shell_scripts/caelestia-color.sh
tmux list-windows -a -F '#{session_name}:#{window_index} #{window_name} #{pane_current_path}' \
  | fzf --ansi \
    --preview 'tmux capture-pane -ep -t {1} | head -100' \
    --preview-window 'right:60%,border-rounded' \
    --color "fg:$($CC primary),border:$($CC primary),pointer:$($CC secondary),hl:$($CC secondary),hl+:$($CC secondary),header:$($CC primaryFixedDim),prompt:$($CC primary),info:$($CC primary)" \
    --border 'rounded' \
    --prompt '🔍 Switch to: ' \
    --header ' Sessions / Windows ' \
    --delimiter ' ' \
  | cut -d' ' -f1 \
  | xargs tmux switch-client -t
