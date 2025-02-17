export SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

ssh_agent_checks() {
  if command ssh-add -L >/dev/null 2>&1; then
    return
  fi

  local message="$1"

  if [ -n "$message" ]; then
    echo "$message"
  else
    echo "No SSH agent set."
  fi

  echo -n "SSH "
  eval "$(command ssh-agent -s)"
  command ssh-add "$SSH_KEY_PATH"
}

SSH_COMMANDS=(ssh ssh-add)

for cmd in "${SSH_COMMANDS[@]}"; do
  eval "
  $cmd() {
    ssh_agent_checks
    command $cmd \"\$@\"
  }
  "
done

declare -A GIT_SSH_COMMANDS=(
  [pull]=1
  [push]=1
  [clone]=1
  [fetch]=1
  [submodule]=1
)

git() {
  if [[ -n "${GIT_SSH_COMMANDS[$1]}" ]]; then
    ssh_agent_checks "Tried to do git commands that require SSH authentication with no SSH agent."
  fi

  command git "$@"
}
