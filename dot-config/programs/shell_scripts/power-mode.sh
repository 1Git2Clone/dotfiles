#!/bin/bash
performance="performance"
balanced="balanced"
powersave="power-saver"
modes=("$performance" "$balanced" "$powersave")
app_name="$(basename "$0")"
app_title="Power Mode"
mode="$(printf "%s\n" "${modes[@]}" | wofi --show dmenu "$app_title")"

if [ -z "$mode" ]; then
  notify-send "$app_title" "⚠️ No option selected (current mode: $(powerprofilesctl get))" --app-name="$app_name"
  exit 0
fi

case $mode in
"$performance")
  powerprofilesctl set performance
  ;;
"$balanced")
  powerprofilesctl set balanced
  ;;
"$powersave")
  powerprofilesctl set power-saver
  ;;
*)
  notify-send "$app_title" "❌ Invalid option selected: $mode" --app-name="$app_name"
  exit 1
  ;;
esac

notify-send "$app_title" "✅ Set power mode to: $mode" --app-name="$app_name"
