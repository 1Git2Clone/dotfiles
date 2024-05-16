###############################################################################
###############################################################################
###############################################################################
#         CONFIGURATION THAT WORKS ON BOTH `BASH` AND `ZSH`                   #
###############################################################################
###############################################################################
###############################################################################

###############################################################################
# Starting echoes
###############################################################################

echo \
	"
⠀⠀⠀⠀⠀⢿⣿⣿⣿⡆⠀⠁⠀⠀⣾⣿⣿⣿⣿⣿⣿⣟⢝⢟⣿⣿⣿⣿⡇⠀
⠀⠀⠀⠀⠀⢸⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣾⣿⣿⣿⢿⣿⡉⠀
⠀⠀⠀⢀⠔⣡⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣶⣿⣷⣄
⠀⠀⢰⣿⣿⡟⣿⣿⣿⡟⠋⠉⢩⠀⠀⠀⠉⠉⠙⢻⠿⣿⣿⣯⣿⣿⣯⣿⡝⣿
⠀⠀⠀⠉⢻⢱⣿⡟⠀⡇⠐⡀⠘⣇⠀⠀⣀⣀⠀⠘⡆⠀⢹⣿⣟⣻⣿⣿⠿⠉
⠀⠀⠀⠀⣈⢻⡇⡇⣼⠻⡒⢣⡀⠸⡙⢍⠈⢮⣍⣁⡇⠀⡎⣗⡿⠀⣿⣿⡀⠀
⢄⣀⣀⣀⣿⡘⡿⣿⣇⣠⣽⣴⣟⠦⣱⣀⣿⣾⣶⣽⡇⢢⣿⡿⠇⠀⣿⣿⣿⣶
⠀⠉⠛⠿⡿⢇⣷⣿⣟⢼⣏⡏⠛⠷⣂⠉⠘⠧⠝⢊⣇⣼⠟⠁⠀⢠⣿⣿⣿⡙
⠀⠀⠀⠀⢘⣼⣼⡿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠄⣚⣿⣿⣯⣭⣲⣼⣿⣿⣿⣷
⠀⠀⠀⠴⠯⠟⣩⣷⣿⣷⣄⠀⠀⠠⠄⠂⠀⠐⡫⠋⣿⣿⣿⣿⣿⣿⣿⡿⣏⠙
⠀⠀⠀⠀⣠⡞⢡⣿⣿⣿⡿⣿⣦⣄⣀⣠⣴⣵⣶⣾⡿⠻⠋⣿⣿⣿⣿⣧⠀⠈
⠀⠀⢀⢞⡟⢰⣬⣼⣿⣿⣷⣿⣿⣿⣾⣿⣿⣿⠿⠋⠀⠀⡼⢿⣾⣿⣿⣿⡀⠀
⠀⠀⠂⣾⠁⢨⣿⠟⢛⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⢀⣾⣷⣎⠙⠻⣿⡟⢆⠀
⠀⠀⠘⡀⠀⣼⣇⣠⠾⠿⠛⠋⠉⠀⠀⠀⠀⠀⠀⣠⣿⠿⠛⠉⣧⠀⠈⠃⠀⡆
⠀⠀⠀⠊⠦⠿⠓⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠞⠉⠀⠀⠀⠀⠈⠆⠀⠀⠀⠄"
echo \
	"
    胡桃ちゃんは一番でーす！ "

###############################################################################
# Aliases
###############################################################################

alias rm='trash'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fm='thunar &'
alias ..='cd ../'
alias ...='cd ../../'
# alias vi='nvim' # pretty goofy yea.
# alias vim='nvim'
alias haskell='cd ~/Documents/Code/Haskell/'
alias c='cd ~/Documents/Code/C/'
alias javascript='cd ~/Documents/Code/JavaScript/'
alias cpp='cd ~/Documents/Code/CPP/'
alias websites='cd ~/Documents/Code/Websites/'
alias python='cd ~/Documents/Code/Python/'
alias py='python3'
alias rust='cd ~/Documents/Code/rust/'
alias golang='cd ~/Documents/Code/go/'
alias c#='cd ~/Documents/Code/C#/'
alias coding='cd ~/Documents/Code/'
alias hyprland-config='cd ~/.config/hypr/'
alias hyprv4-config='cd ~/.config/HyprV/'

alias webapps='cd /usr/share/webapps/'

# KITTY ONLY ALIAS:
alias img='kitten icat'
alias imgl='kitten icat --align left'

alias iliq='kitten icat --align left /home/hutao/Pictures/daskalo/iliq.jpg'
alias iliq2='kitten icat --align left /home/hutao/Pictures/daskalo/iliq2.jpg'

# https://github.com/dylanjcastillo/shell-genie
alias ai='shell-genie ask'

###############################################################################
# Exports
###############################################################################

export EDITOR=nvim

export LC_ALL=en_US.UTF-8
source /etc/locale.conf

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export PATH="$HOME/.config/programs/bin/:$PATH"

export PATH="$PATH:/home/hutao/.cargo/bin"

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

###############################################################################
# Some custom flags
###############################################################################

# Rust app build optimization
RUSTFLAGS="-C opt-level=3 -C target-cpu=native -C linker=rust-lld"

###############################################################################
# Utility functions
###############################################################################

# Run cargo tests when doing cargo run
cargo() {
	if [[ $1 == "run" ]]; then
		command cargo test --all-features && command cargo run "${@:2}"
	else
		command cargo "$@"
	fi
}

nvimterm() {
	if ! pgrep -f "^nvim.*-c terminal" >/dev/null; then
		nvim -c "terminal"
	fi
}

# uncomment this if you want every bash terminal to open in neovim
# some cons:
# - if you open nvim in it you'll have 2 nvim instances opened
# - no pixel image support
# nvimterm
