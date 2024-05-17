###############################################################################
# The .profile config for both Bash and Zsh.
###############################################################################

# NOTE: Contains the $ZSH export
source $HOME/.profile

###############################################################################
# The default ZSH variables.
###############################################################################

# Unneeded due to starship eval.
# ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-vi-mode copyfile zsh-syntax-highlighting \
  catimg colored-man-pages colorize vim-interaction)

source $ZSH/oh-my-zsh.sh

###############################################################################
# Startup programs in the terminal using eval.
###############################################################################

# zoxide + fzf
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init --cmd cd zsh)"

# Starship
# https://github.com/starship/starship
eval "$(starship init zsh)"
