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
case $XDG_SESSION_TYPE in
wayland)
  alias clip='wl-copy'
  ;;
x11)
  alias clip='xclip -selection clipboard'
  ;;
*)
  echo "Unknown session type: $XDG_SESSION_TYPE. Please set up \`clip\` alias manually."
  ;;
esac

alias ff='fastfetch'
alias py='python'

# Git aliases
alias gs='git status'
alias gll='git log --oneline --graph --decorate'
