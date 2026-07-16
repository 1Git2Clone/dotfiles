#!/bin/bash
# Install system-level configs from dotfiles
# Run with sudo: sudo bash system/install.sh

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── Dependency checks ──────────────────────────────────────────────
MISSING=()
command -v sysctl &> /dev/null || MISSING+=(procps-ng)
command -v udevadm &> /dev/null || MISSING+=(systemd)
command -v scxctl &> /dev/null || MISSING+=(scx-scheds)

if [ ${#MISSING[@]} -gt 0 ]; then
  echo "Error: missing required packages: ${MISSING[*]}" >&2
  echo "Install with: sudo pacman -S ${MISSING[*]}" >&2
  exit 1
fi

# ── sysctl ─────────────────────────────────────────────────────────
echo "Installing sysctl config..."
cp "$SCRIPT_DIR/sysctl.d/99-custom.conf" /etc/sysctl.d/99-custom.conf

echo "Reloading sysctl..."
sysctl --system

# ── udev ───────────────────────────────────────────────────────────
echo "Installing udev rules..."
cp "$SCRIPT_DIR/udev/rules.d/60-io-scheduler.rules" /etc/udev/rules.d/60-io-scheduler.rules

echo "Reloading udev rules..."
udevadm control --reload-rules
udevadm trigger

# ── scx-lavd service ──────────────────────────────────────────────
echo "Installing scx-lavd systemd service..."
cp "$SCRIPT_DIR/systemd/system/scx-lavd.service" /etc/systemd/system/scx-lavd.service
systemctl daemon-reload
systemctl enable --now scx-lavd.service

# ── networkd-dispatcher (Tailscale) ──────────────────────────────
echo "Installing Tailscale GRO config..."
mkdir -p /etc/networkd-dispatcher/routable.d
cp "$SCRIPT_DIR/networkd-dispatcher/routable.d/50-tailscale" /etc/networkd-dispatcher/routable.d/50-tailscale
chmod 755 /etc/networkd-dispatcher/routable.d/50-tailscale

echo "Done. Changes are active immediately."
