#!/bin/bash
# Live colours from the current Caelestia scheme (+ mocha.conf for the
# Kitty window backdrop), exported as plain vars. Nothing here is cached —
# re-source this file any time to pick up a scheme change.
_scheme="$HOME/.local/state/caelestia/scheme.json"
_mocha="$HOME/.config/mocha/mocha.conf"

if [ -f "$_scheme" ]; then
  export PRIMARY="#$(jq -r .colours.primary "$_scheme")"
  export ON_PRIMARY="#$(jq -r .colours.onPrimary "$_scheme")"
  export PRIMARY_CONTAINER="#$(jq -r .colours.primaryContainer "$_scheme")"
  export SECONDARY="#$(jq -r .colours.secondary "$_scheme")"
  export PRIMARY_FIXED_DIM="#$(jq -r .colours.primaryFixedDim "$_scheme")"
  export ON_SURFACE="#$(jq -r .colours.onSurface "$_scheme")"
  export SUBTEXT0="#$(jq -r .colours.subtext0 "$_scheme")"
  export OUTLINE="#$(jq -r .colours.outline "$_scheme")"
fi

[ -f "$_mocha" ] && export BACKGROUND="$(awk '/^background /{print $2}' "$_mocha")"
