#!/bin/bash

cursor_pos=$(hyprctl cursorpos)
wl-copy "$cursor_pos"
echo "$cursor_pos" | wofi --dmenu --prompt "Cursor position"
