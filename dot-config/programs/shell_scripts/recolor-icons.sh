#!/bin/bash

COLOR="$1"
shift

if [[ -z "$COLOR" || $# -eq 0 ]]; then
  echo "Usage: $0 <color> <file1> [file2] ..."
  exit 1
fi

for file in "$@"; do
  ext="${file##*.}"
  case "$ext" in
  svg)
    echo "Recoloring $file to $COLOR (SVG)"
    sed -i -E "s/fill=\"#[0-9a-fA-F]{3,6}\"/fill=\"$COLOR\"/g" "$file"
    ;;
  png)
    echo "Recoloring $file to $COLOR (PNG)"
    magick "$file" -fill "$COLOR" -colorize 100 "$file"
    ;;
  *)
    echo "Skipping unsupported file: $file"
    ;;
  esac
done
