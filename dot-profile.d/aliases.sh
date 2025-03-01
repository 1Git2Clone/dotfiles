alias rm='trash'

if command -v lsd >/dev/null 2>&1; then
  alias ls='lsd --color=auto'
else
  alias ls='ls --color=auto'
fi

alias grep='grep --color=auto'
alias fm='thunar & disown'
alias ..='cd ../'
alias ...='cd ../../'

# KITTY ONLY ALIAS:
alias img='kitten icat'
alias imgl='kitten icat --align left'

# Pipe a command to | clip
alias clip='xclip -selection clipboard'

alias ff='fastfetch'
alias py='python'
