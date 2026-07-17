#!/bin/bash
# Install caelestia scheme from dotfiles and apply it live.
# Run as your normal user (NOT with sudo) — only the file copy needs
# root, and it prompts for that on its own. Running the whole script
# under sudo would restart the quickshell dashboard as root instead of
# your user, which breaks its access to your Wayland/D-Bus session.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$EUID" -eq 0 ]; then
  echo "Error: don't run this with sudo — it needs your user's Wayland/D-Bus session to restart the dashboard." >&2
  echo "Run it as yourself: $0" >&2
  exit 1
fi

# ── Dependency checks ──────────────────────────────────────────────
command -v caelestia &> /dev/null || {
  echo "Error: caelestia CLI not found" >&2
  echo "Install caelestia-cli first" >&2
  exit 1
}

# Resolve the caelestia package's schemes dir dynamically (python version varies)
SCHEMES_DIR="$(python3 -c "import caelestia, os; print(os.path.join(os.path.dirname(caelestia.__file__), 'data', 'schemes'))" 2> /dev/null)"
if [ -z "$SCHEMES_DIR" ] || [ ! -d "$SCHEMES_DIR" ]; then
  echo "Error: could not locate caelestia schemes directory" >&2
  exit 1
fi

# ── hu-tao scheme ──────────────────────────────────────────────────
echo "Installing hu-tao scheme..."
sudo mkdir -p "$SCHEMES_DIR/hu-tao/default"
sudo cp "$SCRIPT_DIR/schemes/hu-tao/default/dark.txt" "$SCHEMES_DIR/hu-tao/default/dark.txt"

# ── Apply live ──────────────────────────────────────────────────────
# caelestia keeps the active scheme's colours cached in memory, so
# overwriting dark.txt alone doesn't refresh a scheme that's already
# selected. Bounce through another scheme to force a re-read, then
# restart the dashboard shell so quickshell picks up the new colours.
echo "Applying hu-tao scheme..."
caelestia scheme set -n dynamic
caelestia scheme set -n hu-tao
pkill -f "qs -c caelestia" || true
QT_QPA_PLATFORMTHEME=hyprqt6engine XDG_DATA_DIRS="$XDG_DATA_DIRS" caelestia shell -d

echo "Done."
