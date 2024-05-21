#!/bin/sh

if ! command -v stow >/dev/null 2>&1; then
	echo "You need to have GNU stow installed."
	exit 1
fi

cd ~/dotfiles

stow --adopt --dotfiles home_user/ -t "$HOME/"

mkdir -p "$HOME/.config/obs-studio/plugin_config/advanced-scene-switcher/"
cd ./obs_plugins/
stow --adopt advanced-scene-switcher/ -t "$HOME/.config/obs-studio/plugin_config/advanced-scene-switcher/"
cd ../
stow --adopt --dotfiles config/ -t "$HOME/.config/"

mkdir -p "$HOME/.cargo/"
stow --adopt --dotfiles cargo/ -t "$HOME/.cargo/"
