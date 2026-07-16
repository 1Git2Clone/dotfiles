#!/bin/bash
# Pushes the live Caelestia colours (from colors.sh) into tmux as real
# set-option calls with already-resolved hex — not tmux's own #(...),
# which validates status-style/pane-border-style eagerly at set-time and
# rejects a shell-command placeholder outright ("invalid style").
# Run again (or just `tmux source-file ~/.tmux.conf`) any time to re-sync
# after a scheme switch.
source "$HOME/.profile.d/colors.sh"

tmux set-option -g status-style "fg=$ON_SURFACE,bg=$BACKGROUND,overline"
tmux set-option -g status-left "#[fg=$ON_PRIMARY,bg=$PRIMARY,bold]  #S #[fg=$PRIMARY,bg=$BACKGROUND,nobold]"
tmux set-window-option -g window-status-format "#[fg=$SUBTEXT0,bg=$BACKGROUND] #I  #W "
tmux set-window-option -g window-status-current-format "#[fg=$PRIMARY_CONTAINER,bg=$BACKGROUND] #[fg=$ON_PRIMARY,bg=$PRIMARY_CONTAINER,bold] #I  #W #[fg=$PRIMARY_CONTAINER,bg=$BACKGROUND,nobold] "
tmux set-option -g status-right "#[fg=$PRIMARY,bg=$BACKGROUND]#[fg=$ON_PRIMARY,bg=$PRIMARY]  %H:%M  %d • %b • %y "
tmux set-option -g pane-border-style "fg=$OUTLINE"
tmux set-option -g pane-active-border-style "fg=$PRIMARY"
