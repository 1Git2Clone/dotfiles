#!/bin/bash
# Live colours from the current Caelestia scheme (+ mocha.conf for the
# Kitty window backdrop), exported as plain vars. Nothing here is cached —
# re-source this file any time to pick up a scheme change.
_scheme="$HOME/.local/state/caelestia/scheme.json"
_mocha="$HOME/.config/mocha/mocha.conf"

if [ -f "$_scheme" ]; then
  PRIMARY="#$(jq -r .colours.primary "$_scheme")"
  export PRIMARY
  ON_PRIMARY="#$(jq -r .colours.onPrimary "$_scheme")"
  export ON_PRIMARY
  PRIMARY_CONTAINER="#$(jq -r .colours.primaryContainer "$_scheme")"
  export PRIMARY_CONTAINER
  SECONDARY="#$(jq -r .colours.secondary "$_scheme")"
  export SECONDARY
  PRIMARY_FIXED_DIM="#$(jq -r .colours.primaryFixedDim "$_scheme")"
  export PRIMARY_FIXED_DIM
  ON_SURFACE="#$(jq -r .colours.onSurface "$_scheme")"
  export ON_SURFACE
  SUBTEXT0="#$(jq -r .colours.subtext0 "$_scheme")"
  export SUBTEXT0
  OUTLINE="#$(jq -r .colours.outline "$_scheme")"
  export OUTLINE
fi

if [ -f "$_mocha" ]; then
  BACKGROUND="$(awk '/^background /{print $2}' "$_mocha")"
  export BACKGROUND
fi
