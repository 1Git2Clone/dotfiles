#!/usr/bin/env bash
# PreToolUse hook: deny any tool call that reads, prints, copies, or otherwise
# touches a secret-bearing file (.env*, private keys, credential stores, etc.).
#
# Contract: receives the PreToolUse JSON on stdin, emits a JSON decision on
# stdout. permissionDecision "deny" blocks the call; staying silent (exit 0,
# no JSON) lets the normal permission flow continue.
#
# This is pattern-based defense. It is deliberately broad and fails closed on
# anything that looks like secret access. It is NOT a substitute for an OS-level
# read boundary (sandbox.filesystem.denyRead) -- a determined command can always
# obfuscate a path. Treat this as a strong guardrail, not a vault.

set -uo pipefail

# If we can't parse input, fail OPEN rather than brick every tool call. The
# Read-tool deny rules in settings.json still apply independently.
command -v jq >/dev/null 2>&1 || exit 0

input="$(cat)"
[ -n "$input" ] || exit 0

tool_name="$(printf '%s' "$input" | jq -r '.tool_name // empty' 2>/dev/null)" || exit 0
[ -n "$tool_name" ] || exit 0

# Collect every string leaf in tool_input. Covers file_path (Read/Edit/Write),
# command (Bash), pattern/path (Grep/Glob), notebook_path, edits[].*, etc.,
# without having to special-case each tool's schema.
case "$tool_name" in
  Write|Edit|MultiEdit|NotebookEdit)
    mapfile -t candidates < <(
      printf '%s' "$input" | jq -r '[.tool_input.file_path, .tool_input.notebook_path] | map(select(. != null)) | .[]' 2>/dev/null
    )
    ;;
  *)
    mapfile -t candidates < <(
      printf '%s' "$input" | jq -r '[.tool_input | .. | strings] | .[]' 2>/dev/null
    )
    ;;
esac
[ "${#candidates[@]}" -gt 0 ] || exit 0

# Secret-file signatures. Case-insensitive extended regex. Anchored on word/path
# boundaries so ".environment" or "keyboard.ts" don't trip ".env"/".key".
patterns=(
  '(^|[^a-z0-9_.-])\.env($|[^a-z0-9.])'          # .env (bare; NOT .env.example)
  '(^|[^a-z0-9_.-])\.env\.local($|[^a-z0-9])'
  '(^|[^a-z0-9_.-])\.env\.production($|[^a-z0-9])'
  '(^|[^a-z0-9_.-])\.env\.preprod($|[^a-z0-9])'
  '(^|[^a-z0-9_.-])\.env\.preproduction($|[^a-z0-9])'
  '(^|[^a-z0-9_.-])\.env\.prod($|[^a-z0-9])'
  '(^|[^a-z0-9_.-])\.env\.sandbox($|[^a-z0-9])'
  '(^|[^a-z0-9_.-])\.env\.dev($|[^a-z0-9])'
  '\.pem($|[^a-z0-9])'                    # PEM private keys / certs
  '\.key($|[^a-z0-9])'                    # generic key files
  '\.pfx($|[^a-z0-9])'
  '\.p12($|[^a-z0-9])'
  '\.keystore($|[^a-z0-9])'
  '\.jks($|[^a-z0-9])'
  'id_rsa'
  'id_dsa'
  'id_ecdsa'
  'id_ed25519'
  '(^|/)\.ssh/'                           # anything under an .ssh dir
  '(^|/)\.netrc($|[^a-z0-9])'
  '(^|/)\.pgpass($|[^a-z0-9])'
  '(^|/)\.npmrc($|[^a-z0-9])'
  '(^|/)\.git-credentials($|[^a-z0-9])'
  '(^|/)\.aws/credentials'
  '(^|/)\.docker/config\.json'
  '(^|/)\.kube/config'
  '(^|[^a-z0-9_.-])credentials($|[^a-z0-9])'
  '(^|[^a-z0-9_.-])secrets?($|[^a-z0-9])' # secret / secrets (file or dir)
  'private[._-]?key'
  '\.dev\.vars($|[^a-z0-9])'              # Cloudflare Workers secrets
  'serviceaccount.*\.json'               # GCP service-account keys
)

deny() {
  # $1 = matched needle, $2 = the offending string
  local needle="$1" offender="$2"
  # Truncate the echoed offender so we never splatter a full secret-laden
  # command back into the transcript.
  local shown="${offender:0:80}"
  jq -n --arg reason "Blocked: \"$tool_name\" call references a secret-bearing path (matched: $needle). Access to secret files is denied by the global block-secret-access hook. If this is a legitimate need, edit ~/.claude/hooks/block-secret-access.sh or run the command yourself outside the agent." \
    '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "deny",
        permissionDecisionReason: $reason
      }
    }'
  # stderr line is for the user/debug log, not the model.
  printf 'block-secret-access: denied %s touching %s\n' "$tool_name" "$shown" >&2
  exit 0
}

for c in "${candidates[@]}"; do
  [ -n "$c" ] || continue
  lc="$(printf '%s' "$c" | tr '[:upper:]' '[:lower:]')"
  for p in "${patterns[@]}"; do
    if printf '%s' "$lc" | grep -Eq "$p"; then
      deny "$p" "$c"
    fi
  done
done

# Nothing matched -> allow normal flow.
exit 0
