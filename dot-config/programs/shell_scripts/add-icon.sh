#!/bin/bash

set -e

# Validate args
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 path/to/image.{png,svg} icon-name"
  exit 1
fi

INPUT_IMAGE="$1"
ICON_NAME="$2"
ICON_DIR="$HOME/dotfiles/dot-local/share/icons/hicolor"

# Common icon sizes in freedesktop spec
SIZES=(16 24 32 48 64 96 128 256 512)

echo "[*] Installing icon \"$ICON_NAME\" from \"$INPUT_IMAGE\"..."

# Ensure ImageMagick is installed
if ! command -v convert >/dev/null; then
  echo "[-] Error: imagemagick (convert) not found. Install it with:"
  echo "    sudo pacman -S imagemagick"
  exit 1
fi

# Create directories and resize image for each size
for SIZE in "${SIZES[@]}"; do
  OUTDIR="$ICON_DIR/${SIZE}x${SIZE}/apps"
  mkdir -p "$OUTDIR"

  OUTPUT="$OUTDIR/${ICON_NAME}.png"

  echo "[+] Generating $SIZE x $SIZE icon at $OUTPUT"

  # Resize and export
  magick "$INPUT_IMAGE" -resize "${SIZE}x${SIZE}" "$OUTPUT"
done

if [[ "$INPUT_IMAGE" == *.svg ]]; then
  SVG_DIR="$ICON_DIR/scalable/apps"
  mkdir -p "$SVG_DIR"
  cp "$INPUT_IMAGE" "$SVG_DIR/${ICON_NAME}.svg"
  echo "[+] Copied original SVG to scalable/apps"
fi

echo "[*] Updating icon cache..."
gtk-update-icon-cache "$ICON_DIR"

echo "[✓] Done! You can now use Icon=$ICON_NAME in your .desktop files."
