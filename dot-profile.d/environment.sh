#!/bin/sh
# Environment secrets — pulled from the system keyring via secret-tool.
#
# SC2155 (Declare and assign separately to avoid masking return values):
# `export FOO=$(cmd)` masks the exit code of `cmd` behind the export.
# If `cmd` fails the export still "succeeds" and we get an empty value
# with no signal. Splitting into a separate assignment lets the script
# bail out (or `set -e` will catch it) on a keyring lookup failure.
#
# Splitting also means the var can be `readonly` later, and tools that
# introspect env vars see the same final value.

DEEPSEEK_API_KEY="$(secret-tool lookup account deepseek service api key key)"
export DEEPSEEK_API_KEY

CLAUDE_API_KEY="$(secret-tool lookup account claude service api key key)"
export CLAUDE_API_KEY

CODECOV_TOKEN="$(secret-tool lookup account codecov service api key token)"
export CODECOV_TOKEN

OPENROUTER_TOKEN="$(secret-tool lookup account openrouter service api key token)"
export OPENROUTER_TOKEN

OPENCODE_TOKEN="$(secret-tool lookup account opencode service api key token)"
export OPENCODE_TOKEN
