#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS

DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

state=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [ "$state" = "yes" ]; then
  bluetoothctl power off
else
  bluetoothctl power on
fi
