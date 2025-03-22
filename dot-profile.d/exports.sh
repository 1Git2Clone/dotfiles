# Required for CLI only installs.
GPG_TTY="$(tty)"
export GPG_TTY

# The $ZSH variable is needed for the full_setup.sh
# script which runs in bash by default for
# compatibility sake.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR=nvim

export LC_ALL=en_US.UTF-8

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export PROGRAMS="$HOME/.config/programs/"

export DOTNET_ROOT=$HOME/.dotnet
export PNPM_HOME="$HOME/.local/share/pnpm"

# More likely than not. PATH is already an export.
if [ -z "${PATH-}" ]; then
  export PATH=/usr/local/bin:/usr/bin:/bin
fi

PATH="$PROGRAMS/bin/:$PATH"
PATH="$PROGRAMS/py_scripts/:$PATH"
PATH="$PROGRAMS/shell_scripts/:$PATH"
PATH="$PROGRAMS/ruby/:$PATH"

PATH="$PATH:$HOME/.cargo/bin"

PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/shared_rust_target/release"
PATH="$PATH:$HOME/.spicetify"
PATH="$PATH:$PNPM_HOME"

# Example usage
#
# ```sh
# mkdir "MONTHS[@]" # NOTE: Pivots off your CWD.
# ```
export MONTHS=(
  "January"
  "February"
  "March"
  "April"
  "May"
  "June"
  "July"
  "August"
  "September"
  "October"
  "November"
  "December"
)
