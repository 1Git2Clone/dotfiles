################################################################################
# NOTE: This has to manually be added to your config like so:
#
# zsh:
#
# ```sh
# precmd() {
#   $PROFILE_PROMPT_COMMANDS
# }
# ```
#
# bash:
#
# ```sh
# PROMPT_COMMAND="$PROFILE_PROMPT_COMMANDS; $PROMPT_COMMAND"
# ```
################################################################################

check_git_repo_activity() {
  if [ ! -d .git ]; then
    return
  fi

  upstream_branch="$(command git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)"
  if [ -z "$upstream_branch" ]; then
    return
  fi

  author_email=$(awk '{print $NF}' "$SSH_KEY_PATH.pub")
  if ! command git log --author="$author_email" -n 1 >/dev/null 2>&1; then
    return
  fi

  ssh_agent_checks "Found commits from you whilst there's no SSH agent..."
}

export PROFILE_PROMPT_COMMANDS=(check_git_repo_activity)
