#!/usr/bin/env bash
set -euo pipefail

REMOTE="${1:-origin}"
BRANCH="${2:-main}"

# Stay comfortably below Cloudflare's 100 MiB request limit.
MAX_BYTES=$(( ${MAX_MIB:-80} * 1024 * 1024 ))

die() {
    echo "ERROR: $*" >&2
    exit 1
}

human_size() {
    awk -v n="$1" 'BEGIN {
        if (n >= 1024*1024)
            printf "%.1f MiB", n/(1024*1024)
        else if (n >= 1024)
            printf "%.1f KiB", n/1024
        else
            printf "%d B", n
    }'
}

git rev-parse --verify "$BRANCH^{commit}" >/dev/null 2>&1 ||
    die "Branch '$BRANCH' does not exist."

# ---------------------------------------------------------------------------
# Find the current remote tip.
# ---------------------------------------------------------------------------

remote_tip="$(
    git ls-remote --heads "$REMOTE" "refs/heads/$BRANCH" |
        awk '{print $1}'
)"

if [[ -n "$remote_tip" ]]; then
    echo "Remote: ${remote_tip:0:12}"

    git merge-base --is-ancestor "$remote_tip" "$BRANCH" ||
        die "Remote branch is not an ancestor of local $BRANCH."

    BASE="$remote_tip"
else
    echo "Remote branch does not exist; starting from scratch."
    BASE=""
fi

# ---------------------------------------------------------------------------
# Get commits that aren't on the remote, oldest first.
# ---------------------------------------------------------------------------

commits=()

if [[ -n "$BASE" ]]; then
    while IFS= read -r commit; do
        commits+=("$commit")
    done < <(
        git rev-list --reverse "$BRANCH" "^$BASE"
    )
else
    while IFS= read -r commit; do
        commits+=("$commit")
    done < <(
        git rev-list --reverse "$BRANCH"
    )
fi

TOTAL=${#commits[@]}

((TOTAL > 0)) || {
    echo "Nothing to push."
    exit 0
}

echo "Commits to push: $TOTAL"
echo "Batch target:    $(human_size "$MAX_BYTES")"
echo

# ---------------------------------------------------------------------------
# On-disk size of the objects in a range.
#
# ponytail: --disk-usage reads the local object store instead of building a
# pack, so it runs in milliseconds instead of seconds. It is a slight
# over-estimate of the pushed pack (loose objects aren't deltified), which
# errs toward smaller batches. If batches ever come out too conservative,
# swap in `git pack-objects --stdout | wc -c` here.
# ---------------------------------------------------------------------------

pack_size() {
    local target="$1"
    local base="$2"

    if [[ -n "$base" ]]; then
        git rev-list --disk-usage --objects "$target" "^$base"
    else
        git rev-list --disk-usage --objects "$target"
    fi
}

# ---------------------------------------------------------------------------
# Find the furthest commit that keeps the entire batch under MAX_BYTES.
#
# Binary search because:
#
#   pack(commit N) <= pack(commit N+1)
#
# ---------------------------------------------------------------------------

index=0
base="$BASE"

while ((index < TOTAL)); do

    echo "Finding batch starting at commit $((index + 1))/$TOTAL..."

    # First check whether the very next commit fits.
    first_size="$(pack_size "${commits[index]}" "$base")"

    if ((first_size > MAX_BYTES)); then
        echo
        echo "The next individual commit is too large:"
        echo "  Commit: ${commits[index]:0:12}"
        echo "  Pack:   $(human_size "$first_size")"
        echo "  Limit:  $(human_size "$MAX_BYTES")"
        echo
        die "Cannot split a Git commit across pushes."
    fi

    # Binary search for the furthest commit that still fits.
    # commits[index] is known to fit, so it seeds `best`.
    left=$((index + 1))
    right=$((TOTAL - 1))
    best="$index"

    while ((left <= right)); do
        mid=$(( (left + right) / 2 ))

        size="$(pack_size "${commits[mid]}" "$base")"

        if ((size <= MAX_BYTES)); then
            best="$mid"
            left=$((mid + 1))
        else
            right=$((mid - 1))
        fi
    done

    target="${commits[best]}"
    final_size="$(pack_size "$target" "$base")"

    echo
    echo "========================================"
    echo "PUSHING BATCH"
    echo "========================================"

    if [[ -n "$base" ]]; then
        echo "From: ${base:0:12}"
    else
        echo "From: <empty remote>"
    fi

    echo "To:   ${target:0:12}"
    echo "Commits: $((best - index + 1))"
    echo "Pack: $(human_size "$final_size")"
    echo

    if [[ -n "${DRY_RUN:-}" ]]; then
        echo "DRY_RUN: skipping push."
        base="$target"
        index=$((best + 1))
        continue
    fi

    git push "$REMOTE" \
        "$target:refs/heads/$BRANCH"

    # Verify the actual remote ref.
    actual="$(
        git ls-remote --heads "$REMOTE" "refs/heads/$BRANCH" |
            awk '{print $1}'
    )"

    [[ "$actual" == "$target" ]] ||
        die "Remote verification failed.
Expected: $target
Got:      ${actual:-<empty>}"

    echo "Remote verified: ${actual:0:12}"
    echo

    # Everything through target is now safely on the remote.
    base="$target"
    index=$((best + 1))

done

echo "========================================"
echo "DONE"
echo "========================================"

git ls-remote --heads "$REMOTE"
