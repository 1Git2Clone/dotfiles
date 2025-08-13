#!/bin/bash

LANGUAGES=("eng" "fra" "deu" "spa" "rus" "jpn" "kor" "bul")
DEFAULT_LANG="eng"

for lang in "${LANGUAGES[@]}"; do
  if ! tesseract --list-langs | grep -q "$lang"; then
    echo "Warning: Language '$lang' is not installed for Tesseract."
  fi
done

SELECTED_LANG="${1:-$(printf "%s\n" "${LANGUAGES[@]}" | wofi --dmenu --prompt "OCR Language" --width 200 --height 150)}"
LANG=${SELECTED_LANG:-$DEFAULT_LANG}

TMPFILE=$(mktemp --suffix=.png)
grim -g "$(slurp)" "$TMPFILE"

# swappy -f "$TMPFILE" -o "$TMPFILE" || true

text=$(tesseract "$TMPFILE" stdout -l "$LANG")
wl-copy "$text"

notify-send --app-name "tesseract-screenshot.sh" "✅ OCR Success" "Copied \"$text\" to clipboard!"

rm "$TMPFILE"
