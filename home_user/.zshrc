###############################################################################
# The default ZSH variables.
###############################################################################

export ZSH="$HOME/.oh-my-zsh"

# Unneeded due to starship eval.
# ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

###############################################################################
# The .profile config for both Bash and Zsh.
###############################################################################

source $HOME/.profile

###############################################################################
# Startup programs in the terminal using eval.
###############################################################################

# zoxide + fzf
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init --cmd cd zsh)"

# Starship
# https://github.com/starship/starship
eval "$(starship init zsh)"
