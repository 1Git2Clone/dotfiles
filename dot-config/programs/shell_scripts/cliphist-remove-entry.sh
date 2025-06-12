#!/bin/bash

entry=$(cliphist list | wofi --dmenu --prompt "Pick an entry to remove")
echo "$entry" | cliphist delete
notify-send --app-name "cliphist-remove-entry.sh" "✅ Removed entry" "$entry"
