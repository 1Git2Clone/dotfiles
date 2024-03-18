#
# ~/.config/.bashrc
#
# NOTE: To make it work, you either need
# a ~/.bashrc with
# source ~/.config/.bashrc
# OR
# You need to move this file to ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias rm='trash'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# alias vi='nvim' # pretty goofy yea.
# alias vim='nvim'
alias haskell='cd ~/Documents/Code/Haskell/'
alias c='cd ~/Documents/Code/C/'
alias javascript='cd ~/Documents/Code/JavaScript/'
alias c-personal='cd ~/Documents/Code/C-personal/'
alias cpp='cd ~/Documents/Code/CPP/'
alias websites='cd ~/Documents/Code/Websites/'
alias python='cd ~/Documents/Code/Python/'
alias py='python3'
alias rust='cd ~/Documents/Code/rust/'
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

export PATH=$PATH:/opt/rocm/bin
export HIP_PATH=/opt/rocm

export EDITOR=nvim
PS1='[\u@\h \W]\$ '

export LC_ALL=en_US.UTF-8
source /etc/locale.conf

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

eval "$(starship init bash)"

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export PATH="$HOME/.config/programs/bin/:$PATH"
# export PATH="$HOME/.config:$PATH"

# echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣵⣿⣿⣿⢻⣿⡾⣿⡛⠿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⡇⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠠⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣮⠙⢷⣜⢷⣤⣿⣿⣿⣯⣿⣿⣿⣿⣿⣷⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣴⣴⣶⣶⣶⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢏⣷⢄⡿⣦⣻⣿⣿⣿⣿⣿⢿⣿⣟⡿⠟⠓⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣾⣿⣿⣿⣿⣿⣿⣿⢿⣟⣿⣿⣿⣧⡀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠛⠁⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣽⣿⣿⣷⢶⣇⣉⣽⣿⣿⣇⠀⠠⠖
# ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠋⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⣿⣯⣿⣿⣿⣿⣿⣦⠀
# ⠀⠀⠀⠀⠀⠀⠀⣴⢟⣡⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧
# ⠀⠀⠀⠀⠀⢰⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢱⣿⣿⣿⣿⣿⣏⢻⣿⣧⡙⢿⣿⣿
# ⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⡿⢀⣿⣿⣿⣿⣿⠟⢻⡄⠀⠀⠀⠀⠀⠀⠸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡄⡉⠛⠿⣿⣿⣿⣵⣿⣿⣿⣿⣿⣿⣿⢀⣿⣿⣷⡌⢿⣿
# ⠀⠀⠀⠀⠀⠀⠈⠙⠻⠿⣿⡇⣸⣿⣿⣿⡿⠁⠀⢸⡇⠀⠀⣴⠀⠀⠀⢻⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣷⠁⠀⠀⠈⠉⢿⣿⣝⠿⣿⣿⣿⢿⣷⣾⣿⠿⠟⣛⠹⠛
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠀⣿⣿⡿⢹⡇⠀⠀⣸⣧⠀⠀⠸⡖⠀⠀⠀⢿⣧⡀⠀⠀⠀⣀⣤⣤⣤⣀⡀⠀⠀⠀⣿⡄⠀⠀⠀⢠⣼⣿⣹⣿⣶⣶⡾⢿⣿⣿⣿⡏⠉⠉⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢳⡇⣿⣿⠀⢼⡀⠀⢠⣿⣽⣦⣤⣄⢿⡀⠀⠀⠈⢿⠻⣦⡾⠛⠉⠉⢿⣍⡉⠉⠛⠷⠦⣿⡇⠀⠂⠀⣸⠻⣿⣸⣿⣿⡏⠀⢸⣿⣿⣿⠇⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣬⣾⠃⣿⣿⠀⣼⡇⣠⣿⠋⠈⣿⣄⠀⠘⣷⡄⠀⠀⠘⣧⠈⠻⣦⣀⠀⠀⢿⡻⣶⣤⣀⣀⢸⣿⠀⠀⠀⣿⢸⣿⢨⣿⡟⠁⠀⢸⣿⣿⣿⣷⣄⠀⠀⠀
# ⠸⠀⠀⠀⠀⠀⠀⠀⢰⣷⢿⡀⣿⣿⡆⣿⣧⣸⡏⠀⠀⠈⢿⣎⠠⠸⣿⣦⡀⠀⠙⣇⠀⠀⠙⣳⣦⣬⣿⣄⠙⠻⠿⣿⡇⢀⠀⢰⡏⣼⡿⣼⣿⡇⠀⠀⢸⣿⣿⣿⣿⣿⣷⣄⡀
# ⣦⣤⣀⡀⠀⠀⢀⣀⣼⣿⣾⡇⢹⣿⡇⣿⣿⣟⣄⣠⣤⣀⡼⣿⣦⠻⣿⣎⠛⢶⣄⣸⣦⠀⣚⣭⣶⣿⣿⣿⣿⣿⣿⣾⡇⠈⢀⡟⣽⣿⣡⡿⣹⠁⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿
# ⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⡅⢿⣿⣿⣿⡿⢿⣿⣿⢿⣿⣿⡜⣻⣷⡀⠉⠛⠻⢿⣏⢹⣿⣯⡉⢹⣿⡇⣸⢻⡇⢀⢘⣵⣿⣿⠟⠁⠁⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⠀⠀⠀⠈⠙⠻⠿⠿⢿⣿⠿⣷⠈⣿⣿⣾⣿⣿⡌⢳⡀⣿⣷⠀⣿⠈⠙⠿⣿⣯⡓⠒⠀⠀⠀⠈⢻⣯⠤⠬⠿⠶⠁⣾⠃⣠⣾⣿⡿⠋⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣷⡈⠙
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⠘⣧⢹⣿⣽⣿⣿⣿⡀⠈⠚⠛⠛⠃⠀⠀⠀⠀⠈⠙⠓⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣯⣾⣿⣿⣿⣄⣀⣀⣀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣷⡀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠇⢠⣿⣎⢿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠾⠟⣿⣿⣿⣿⣿⣯⣍⣉⣙⢿⣶⡄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣽⣿⣯⠈⢻⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣉⣠⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣾⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿
# ⠀⠀⠀⠀⠀⠀⢀⣠⣾⡿⣡⣯⣿⠟⠉⣿⣷⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⣀⠀⠀⢀⣠⡤⠀⠀⠀⠶⠶⠶⠟⣻⡟⢋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡌⠉⠻⢿
# ⠀⠀⠀⠀⠀⠀⠉⠛⠛⠋⠉⠉⠀⣠⡾⢹⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠉⠉⠉⠀⠀⠀⠀⠀⠀⢀⡴⠞⠁⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠻⢿⣦⡀⠀
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⠋⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⢹⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⣀⡤⢞⣉⣤⣤⣤⣼⣿⣿⣿⠟⣿⡟⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠙⠳
# ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⠃⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⠏⣼⣿⣿⣿⣷⣦⣀⣀⡤⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠘⠋⠀⢰⣿⡟⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀⣠⡾⣻⡿⠋⢀⠀⡿⠛⢡⣿⣿⣿⣿⣿⣯⣤⣿⣿⣿⣿⣿⣿⣏⣡⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠋⠀⠀⠀⠀⢀⣾⣻⣿⣘⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⣼⠋⣸⡟⠀⠀⣼⢸⣧⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⢀⣿⡿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀
# ⠀⠀⠀⠀⢀⡾⠃⣰⣿⡇⠀⠀⡏⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⢀⣾⣯⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣃⠀⠀⠀
# ⠀⠀⠀⠀⡼⠁⢰⣿⡟⠀⠀⠀⣤⣿⣿⣿⡿⠟⠋⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣷⣟⠂⠀⠹⠿⠿⣿⣿⣿⣿⠸⠿⠀⠀⠀
# ⠀⠀⠀⠐⠃⠀⣿⠻⠁⠀⠀⢀⣿⣿⠿⠇⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⢻⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣷⣠⠂⠀⠀⠸⢿⣿⡇⠀⠀⢣⠀⠀
# ⠀⠀⠀⠀⠀⠀⣿⠀⠀⢀⠀⢸⣿⣿⠀⠀⠀⣰⣿⣿⣿⣿⡟⠋⠙⠉⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⠟⠛⠉⠙⢿⡆⠀⠀⠀⠀⠻⣷⠀⠀⠨⣦⠀
# ⠀⠀⠀⠀⠀⠀⡴⡄⠀⢀⠀⣾⣏⣭⠴⠾⠟⠋⠁⠀⠉⢀⣀⠀⣀⡀⠠⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⠿⠛⠉⠀⠀⠀⠀⠐⠾⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⡼⠁
# ⠀⠀⠀⠀⠀⠜⢠⡼⣣⡤⢀⣿⣿⠿⠷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣼⡿⠾⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣷⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀
# ⠀⠀⠀⠀⠀⠀⠠⠔⠊⠙⠛⠛⠿⠆⠀⣈⣻⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠴⠀⣠⣶⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠆⠀⠀⠀⠀⠀⠀⠀⠽"
# echo "			胡桃ちゃんは一番でーす！"

echo "
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
echo "    胡桃ちゃんは一番でーす！"

[ -f "/home/hutao/.ghcup/env" ] && source "/home/hutao/.ghcup/env" # ghcup-env
. "$HOME/.cargo/env"

# Run cargo tests when doing cargo run
cargo() {
	if [[ $1 == "run" ]]; then
		command cargo test && command cargo run "${@:2}"
	else
		command cargo "$@"
	fi
}

neovimterm() {
	if ! pgrep -f "^nvim.*-c terminal" >/dev/null; then
		nvim -c "terminal"
	fi
}

# uncomment this if you want every bash terminal to open in neovim
# some cons:
# - if you open nvim in it you'll have 2 nvim instances opened
# - no pixel image support
# neovimterm

# zoxide + fzf
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init --cmd cd bash)"

# Rust app build optimization
RUSTFLAGS="-C opt-level=3 -C target-cpu=native -C linker=rust-lld -C inline-threshold=250"
