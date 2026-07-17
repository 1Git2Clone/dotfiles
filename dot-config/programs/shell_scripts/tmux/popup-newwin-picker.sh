#!/bin/bash
# fzf body for the "new window" popup (bind c). Colours are re-read from
# the live Caelestia scheme on every launch.
CC=~/.config/programs/shell_scripts/caelestia-color.sh
{
  echo "$HOME"
  zoxide query -l
} |
  fzf \
    --color "fg:$($CC primary),pointer:$($CC secondary),hl:$($CC secondary),hl+:$($CC secondary),header:$($CC primaryFixedDim),prompt:$($CC primary),info:$($CC primary)" \
    --prompt '  dir: ' \
    --header ' New Window ' |
  xargs -r ~/.config/programs/shell_scripts/tmux/new-named-window.sh
