#!/bin/bash
# Print a hex colour (with leading #) from the *live* Caelestia scheme,
# read fresh from disk on every call so callers stay in sync with
# whatever scheme is currently active (no baked-in hex, no reload hooks).
# Usage: caelestia-color.sh <key>   e.g. primary, secondary, primaryFixedDim
key="$1"
scheme="$HOME/.local/state/caelestia/scheme.json"
jq -r --arg k "$key" '"#" + .colours[$k]' "$scheme"
