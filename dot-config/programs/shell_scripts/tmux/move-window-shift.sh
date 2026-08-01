#!/usr/bin/env bash
# Drop-in replacement for `move-window -t <index>`: if the target index
# is occupied, shift the windows between source and target by one
# instead of refusing with "index in use".
set -euo pipefail

target="$1"
[[ "$target" =~ ^[0-9]+$ ]] || exit 0

session="$(tmux display-message -p '#{session_name}')"
src_id="$(tmux display-message -p '#{window_id}')"
src_idx="$(tmux display-message -p '#{window_index}')"

(( target == src_idx )) && exit 0

if ! tmux list-windows -t "$session" -F '#{window_index}' | grep -qx "$target"; then
    tmux move-window -s "$src_id" -t "${session}:${target}"
    exit 0
fi

# Park the source on a scratch index nothing else can occupy, so the
# shift below never has to fight the source for its own old slot.
scratch=$(( $(tmux list-windows -t "$session" -F '#{window_index}' | sort -n | tail -1) + 1 ))
tmux move-window -s "$src_id" -t "${session}:${scratch}"

mapfile -t windows < <(tmux list-windows -t "$session" -F '#{window_index} #{window_id}' | sort -n)

if (( target > src_idx )); then
    for entry in "${windows[@]}"; do
        idx="${entry%% *}"; id="${entry#* }"
        (( idx > src_idx && idx <= target )) && tmux move-window -s "$id" -t "${session}:$((idx - 1))"
    done
else
    for ((i = ${#windows[@]} - 1; i >= 0; i--)); do
        idx="${windows[i]%% *}"; id="${windows[i]#* }"
        (( idx >= target && idx < src_idx )) && tmux move-window -s "$id" -t "${session}:$((idx + 1))"
    done
fi

tmux move-window -s "$src_id" -t "${session}:${target}"
