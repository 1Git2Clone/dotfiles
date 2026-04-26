#!/bin/bash
# Interactive screenshot selection with hyprshot

SCREENSHOTS_DIR="$HOME/Pictures"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SCREENSHOT_PATH="$SCREENSHOTS_DIR/Screenshot-$TIMESTAMP.png"

# Capture region with hyprshot using timestamped filename
TEMP_NAME="Screenshot-$TIMESTAMP.png"
hyprshot -m region --freeze -s -f "$TEMP_NAME" -o "$SCREENSHOTS_DIR" 2>/dev/null

# Check if screenshot was taken
if [[ ! -f "$SCREENSHOT_PATH" ]]; then
  notify-send -a "hyprland" "Screenshot cancelled or failed"
  exit 1
fi

# Copy to clipboard
wl-copy < "$SCREENSHOT_PATH"

# Show notification with Open action (consistent with focused monitor)
ACTION=$(notify-send -a "hyprland" \
  -i "$SCREENSHOT_PATH" \
  -A "open=Open" \
  "Screenshot saved" \
  "$SCREENSHOT_PATH")

# Handle open action with fallback chain
if [[ "$ACTION" == "open" ]]; then
  if command -v nautilus &>/dev/null; then
    nautilus -w "$SCREENSHOT_PATH" &
  elif command -v swappy &>/dev/null; then
    swappy -f "$SCREENSHOT_PATH" &
  else
    xdg-open "$SCREENSHOT_PATH" &
  fi
fi
