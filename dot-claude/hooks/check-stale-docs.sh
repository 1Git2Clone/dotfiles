#!/usr/bin/env bash
# Stop hook: nudge if this turn changed code but left README.md / CHANGELOG.md
# untouched. Only warns about a doc that actually exists in the repo, so projects
# without a CHANGELOG aren't pestered.
#
# Re-fires only when the relevant diff actually changes. Once a given diff has
# been flagged and the conversation continues past it (the user/agent decided
# docs weren't needed, or can't change the diff right now), it won't nag again
# on every subsequent turn for that same unchanged diff — only if new files
# enter the diff or existing ones change further. State is a content hash
# cached at .git/.claude-stale-docs-hash (gitignored implicitly, lives in .git).
set -euo pipefail

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')

[ -n "$cwd" ] && cd "$cwd" 2>/dev/null || exit 0
command -v git >/dev/null 2>&1 || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
state_file="$root/.git/.claude-stale-docs-hash"

# Nothing to check if neither doc exists.
have_readme=0; have_changelog=0
[ -f "$root/README.md" ] && have_readme=1
[ -f "$root/CHANGELOG.md" ] && have_changelog=1
[ "$have_readme" = 0 ] && [ "$have_changelog" = 0 ] && exit 0

# Scope of "this work": uncommitted changes plus anything on the current branch
# that isn't on the default branch yet.
default=$(git symbolic-ref --quiet refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
[ -z "$default" ] && default=main
base=""
for ref in "origin/$default" "$default"; do
  if git rev-parse --verify -q "$ref" >/dev/null 2>&1; then base="$ref"; break; fi
done

changed=$(
  {
    git diff --name-only
    git diff --name-only --cached
    if [ -n "$base" ]; then git diff --name-only "$base"...HEAD 2>/dev/null; fi
  } | sort -u
)
if [ -z "$changed" ]; then rm -f "$state_file"; exit 0; fi

# Implementation = any changed file that isn't one of the docs themselves.
impl=$(printf '%s\n' "$changed" | grep -viE '(^|/)(README|CHANGELOG)\.md$' || true)
if [ -z "$impl" ]; then rm -f "$state_file"; exit 0; fi

readme_touched=$(printf '%s\n' "$changed" | grep -iqE '(^|/)README\.md$' && echo 1 || echo 0)
changelog_touched=$(printf '%s\n' "$changed" | grep -iqE '(^|/)CHANGELOG\.md$' && echo 1 || echo 0)

missing=()
[ "$have_readme" = 1 ]    && [ "$readme_touched" = 0 ]    && missing+=("README.md")
[ "$have_changelog" = 1 ] && [ "$changelog_touched" = 0 ] && missing+=("CHANGELOG.md")
if [ ${#missing[@]} -eq 0 ]; then rm -f "$state_file"; exit 0; fi

# Hash the impl diff content (not just filenames) so edits within already-flagged
# files still re-trigger, but an unchanged diff doesn't nag again every turn.
mapfile -t impl_files <<<"$impl"
content_hash=$(
  {
    git diff -- "${impl_files[@]}" 2>/dev/null
    git diff --cached -- "${impl_files[@]}" 2>/dev/null
    [ -n "$base" ] && git diff "$base"...HEAD -- "${impl_files[@]}" 2>/dev/null
  } | sha256sum | cut -d' ' -f1
)

if [ -f "$state_file" ] && [ "$(cat "$state_file")" = "$content_hash" ]; then
  # Same diff already flagged once before; don't re-nag every turn.
  exit 0
fi

printf '%s' "$content_hash" >"$state_file"

list=$(printf '%s, ' "${missing[@]}"); list=${list%, }
reason="This work changed code but left ${list} untouched. If the change is user-facing or notable, update ${list} (and any version bump) before finishing — otherwise briefly confirm it doesn't warrant a doc/changelog entry, then stop."

jq -n --arg r "$reason" '{decision: "block", reason: $r}'
exit 0
