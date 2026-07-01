#!/usr/bin/env bash
# Claude Code status line — no truncation, full info on one line.

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // "?"')
dir=$(basename "$cwd")

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
remaining_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')

# Format token counts as human-readable (k suffix)
fmt_tokens() {
  local n="$1"
  if [ -z "$n" ] || [ "$n" = "null" ]; then
    echo "?"
    return
  fi
  if [ "$n" -ge 1000 ] 2> /dev/null; then
    printf "%.1fk" "$(echo "scale=1; $n / 1000" | bc)"
  else
    echo "$n"
  fi
}

in_fmt=$(fmt_tokens "$total_in")
out_fmt=$(fmt_tokens "$total_out")

# Context usage segment
ctx_seg=""
if [ -n "$used_pct" ]; then
  ctx_seg=$(printf "Ctx: %.0f%% used" "$used_pct")
  if [ -n "$remaining_pct" ]; then
    ctx_seg=$(printf "Ctx: %.0f%% used / %.0f%% left" "$used_pct" "$remaining_pct")
  fi
fi

# Token segment
tok_seg=""
if [ -n "$total_in" ] && [ "$total_in" != "null" ]; then
  tok_seg="In: ${in_fmt} | Out: ${out_fmt}"
fi

# Rate limit segment (Claude.ai subscribers)
rate_seg=""
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
if [ -n "$five_pct" ] || [ -n "$week_pct" ]; then
  parts=()
  [ -n "$five_pct" ] && parts+=("5h: $(printf '%.0f' "$five_pct")%")
  [ -n "$week_pct" ] && parts+=("7d: $(printf '%.0f' "$week_pct")%")
  rate_seg=$(
    IFS=' | '
    echo "${parts[*]}"
  )
fi

# Git repo segment
repo=$(echo "$input" | jq -r '.workspace.repo | if . then .owner + "/" + .name else empty end')
git_seg=""
[ -n "$repo" ] && git_seg="$repo"

# PR segment
pr_num=$(echo "$input" | jq -r '.pr.number // empty')
pr_seg=""
if [ -n "$pr_num" ]; then
  pr_state=$(echo "$input" | jq -r '.pr.review_state // "open"')
  pr_seg="PR #${pr_num} (${pr_state})"
fi

# Session name
session_name=$(echo "$input" | jq -r '.session_name // empty')
session_seg=""
[ -n "$session_name" ] && session_seg="Session: ${session_name}"

# Effort level
effort=$(echo "$input" | jq -r '.effort.level // empty')
effort_seg=""
[ -n "$effort" ] && effort_seg="Effort: ${effort}"

# Vim mode
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
vim_seg=""
[ -n "$vim_mode" ] && vim_seg="[$vim_mode]"

# Assemble segments — only include non-empty ones
segments=()
[ -n "$vim_seg" ] && segments+=("$vim_seg")
[ -n "$dir" ] && segments+=("$dir")
[ -n "$git_seg" ] && segments+=("$git_seg")
[ -n "$pr_seg" ] && segments+=("$pr_seg")
[ -n "$model" ] && segments+=("Model: $model")
[ -n "$effort_seg" ] && segments+=("$effort_seg")
[ -n "$ctx_seg" ] && segments+=("$ctx_seg")
[ -n "$tok_seg" ] && segments+=("$tok_seg")
[ -n "$rate_seg" ] && segments+=("$rate_seg")
[ -n "$session_seg" ] && segments+=("$session_seg")

# Join with separator
(
  IFS=' | '
  echo "${segments[*]}"
)
