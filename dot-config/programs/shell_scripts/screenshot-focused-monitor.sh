#!/bin/bash
# Screenshot focused monitor with notification, copy to clipboard, and open option

SCREENSHOTS_DIR="$HOME/Pictures"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SCREENSHOT_PATH="$SCREENSHOTS_DIR/Screenshot-$TIMESTAMP.png"

# Get focused monitor geometry
MONITOR_GEO=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.x),\(.y) \(.width)x\(.height)"')

if [[ -z "$MONITOR_GEO" ]]; then
  notify-send -a "hyprland" "Failed to get focused monitor"
  exit 1
fi

# Capture focused monitor
grim -g "$MONITOR_GEO" "$SCREENSHOT_PATH"

if [[ ! -f "$SCREENSHOT_PATH" ]]; then
  notify-send -a "hyprland" "Failed to save screenshot"
  exit 1
fi

# Copy to clipboard
wl-copy < "$SCREENSHOT_PATH"

# Show notification with open action
ACTION=$(notify-send -a "hyprland" \
  -i "$SCREENSHOT_PATH" \
  -A "open=Open" \
  "Screenshot saved" \
  "$SCREENSHOT_PATH")

# Handle open action
if [[ "$ACTION" == "open" ]]; then
  xdg-open "$SCREENSHOT_PATH" &
fi
