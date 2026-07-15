#!/bin/bash
# Install caelestia scheme from dotfiles
# Run with sudo: sudo bash caelestia/install.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── Dependency checks ──────────────────────────────────────────────
command -v caelestia &>/dev/null || {
  echo "Error: caelestia CLI not found" >&2
  echo "Install caelestia-cli first" >&2
  exit 1
}

# Resolve the caelestia package's schemes dir dynamically (python version varies)
SCHEMES_DIR="$(python3 -c "import caelestia, os; print(os.path.join(os.path.dirname(caelestia.__file__), 'data', 'schemes'))" 2>/dev/null)"
if [ -z "$SCHEMES_DIR" ] || [ ! -d "$SCHEMES_DIR" ]; then
  echo "Error: could not locate caelestia schemes directory" >&2
  exit 1
fi

# ── hu-tao scheme ──────────────────────────────────────────────────
echo "Installing hu-tao scheme..."
mkdir -p "$SCHEMES_DIR/hu-tao/default"
cp "$SCRIPT_DIR/schemes/hu-tao/default/dark.txt" "$SCHEMES_DIR/hu-tao/default/dark.txt"

echo "Done. Activate with: caelestia scheme set -n hu-tao"
