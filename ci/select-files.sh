#!/usr/bin/env bash
#
# ci/select-files.sh — list tracked files matching a glob, with
# vendored content excluded.
#
# Vendored = "tracked here, but authored upstream, don't lint".
# Today the only such tree is `dot-config/opencode/skills/`. If a
# new vendored tree is added later, append it to VENDOR_PATHS.
#
# Everything else (node_modules, dist, lockfiles, generated
# configs) is already covered by .gitignore. We do not duplicate
# those rules here — see the root .gitignore for the full set.
#
# Usage:
#   ./ci/select-files.sh '*.sh'           # prints file list
#   ./ci/select-files.sh '*.json' '*.jsonc'
#
# Sourced:
#   source ci/select-files.sh
#   select_files '*.sh'
#   echo "$SELECTED_FILES"

set -euo pipefail

VENDOR_PATHS=(
  'dot-config/opencode/skills/'
)

select_files() {
  if [[ $# -eq 0 ]]; then
    echo "select_files: at least one glob required" >&2
    return 2
  fi
  local exclude_re
  exclude_re="$(
    IFS='|'
    echo "${VENDOR_PATHS[*]}"
  )"
  SELECTED_FILES="$(git ls-files "$@" | grep -vE "$exclude_re" || true)"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  select_files "$@"
  printf '%s\n' "$SELECTED_FILES"
fi
