#!/bin/bash
dir="$1"
[ -z "$dir" ] && exit 0
name="$(basename "$dir")"
existing="$(tmux list-windows -F '#{window_name}')"
final="$name"
n=2
while printf '%s\n' "$existing" | grep -qx "$final"; do
  final="${name}-${n}"
  n=$((n + 1))
done
tmux new-window -c "$dir" -n "$final"
