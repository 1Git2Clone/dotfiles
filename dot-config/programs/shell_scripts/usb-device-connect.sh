#!/bin/bash

USB_SOUND_FILE=""

export DISPLAY=:0
export XDG_RUNTIME_DIR
XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY=wayland-1

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

authorize_with_usbguard() {
  local sysfs_path="$1"
  local dev_name="$2"
  local dev_vendor="$3"

  if ! command -v usbguard >/dev/null 2>&1; then
    return
  fi
  if ! systemctl is-active --quiet usbguard; then
    return
  fi

  usb_port=$(basename "$sysfs_path")

  if zenity --question \
    --title="USB Authorization" \
    --text="Authorize $dev_vendor $dev_name?" \
    --ok-label="Allow" \
    --cancel-label="Block"; then

    pkexec env DISPLAY="$DISPLAY" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" bash -c "
      device_id=\"\$(usbguard list-devices | grep 'via-port \"$usb_port\"' | awk '{print \$1}' | tr -d ':')\"
      if [ -n \"\$device_id\" ]; then
        usbguard allow-device \$device_id
      fi
    "
  fi
}

# --- Listen to udev for added USB devices ---
udevadm monitor --udev --subsystem-match=usb |
  while read -r line; do
    # Only process "add" events
    if ! echo "$line" | grep -q "add"; then
      continue
    fi

    # Only top-level USB device events
    if ! echo "$line" | grep -Eq "/usb[0-9]+(/[0-9.-]+)? \(usb\)$"; then
      continue
    fi

    sysfs_path=$(echo "$line" | awk '{print $4}')

    dev_name=$(udevadm info -q property -p "$sysfs_path" 2>/dev/null | grep '^ID_MODEL=' | cut -d= -f2)
    dev_vendor=$(udevadm info -q property -p "$sysfs_path" 2>/dev/null | grep '^ID_VENDOR=' | cut -d= -f2)

    [ -z "$dev_name" ] && dev_name="Unknown Device"
    [ -z "$dev_vendor" ] && dev_vendor="Unknown Vendor"

    notify-send "USB device plugged in" "$dev_vendor $dev_name"
    if [ -n "$USB_SOUND_FILE" ]; then
      paplay "$USB_SOUND_FILE" &
    fi

    usb_port=$(basename "$sysfs_path")
    journalctl -kf | while read -r kline; do
      if echo "$kline" | grep -q "usb $usb_port: Device is not authorized"; then
        authorize_with_usbguard "$sysfs_path" "$dev_name" "$dev_vendor"
        break
      fi
    done &
  done
