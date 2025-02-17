export SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

ignored_ssh_directories=("")

undo_last_ignored_dir() {
  unset "ignored_ssh_directories[-1]"
}

ssh_agent_checks() {
  dir=$(command pwd)

  for ignored_dir in "${ignored_ssh_directories[@]}"; do
    if [[ "$dir" == "$ignored_dir" ]]; then
      return
    fi
  done

  case $0 in
  "zsh")
    read -r "response?Set up SSH agent now or ignore $dir? (y/N): "
    response=${response:l}
    ;;
  "bash")
    read -p "Set up SSH agent now or ignore $dir? (y/N): " response
    response=${response,,}
    ;;
  esac

  case "${response}" in
  "yes" | "y") ;;
  *)
    ignored_ssh_directories+=("$dir")
    echo "Added $dir to the ignored ssh directories."
    echo "If this was a mistake then you can remove it by undo_last_ignored_dir function."
    echo "You can always run ssh_agent_checks to set up your SSH agent."
    return
    ;;
  esac

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

declare -A GITHUB_CLI_REPO_SSH_COMMANDS=(
  [clone]=1
  [delete]=1
  [fork]=1
  [edit]=1
  [sync]=1
  [rename]=1
  [create]=1
  [add]=1
)

declare -A GITHUB_CLI_PR_SSH_COMMANDS=(
  [create]=1
)

gh() {
  local msg="Tried to do GitHub CLI commands that require SSH authentication with no SSH agent."

  case "$1" in
  "pr") ${GITHUB_CLI_PR_SSH_COMMANDS[$2]} || ssh_agent_checks "$msg" ;;
  "repo") ${GITHUB_CLI_REPO_SSH_COMMANDS[$2]} || ssh_agent_checks "$msg" ;;
  esac

  command gh "$@"
}
