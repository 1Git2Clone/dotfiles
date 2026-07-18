#!/bin/sh
# Generic Proton launcher: picks the real game exe out of a directory by
# excluding known crash-handler/updater stubs, so nothing game-specific
# needs to be hardcoded anywhere.
# Usage: run.sh <game-dir>
set -e

gamedir=$1
if [ -z "$gamedir" ] || [ ! -d "$gamedir" ]; then
    echo "usage: $0 <game-dir>" >&2
    exit 1
fi

exe=$(find -L "$gamedir" -maxdepth 1 -iname "*.exe" \
    ! -iname "*crash*" ! -iname "*sys_global*" ! -iname "*upload*" \
    ! -iname "*launcher*" ! -iname "*createdump*" | head -n1)

if [ -z "$exe" ]; then
    echo "no game exe found in $gamedir" >&2
    exit 1
fi

export WINEPREFIX="$HOME/Games/umu/umu-default"
export GAMEID=umu-default
export PROTONPATH=/usr/share/steam/compatibilitytools.d/dwproton
exec gamemoderun mangohud umu-run "$exe"
