#!/bin/bash

###############################################################################
# On Ctrl+C handler
###############################################################################

cleanup() {
	rm -rf "$HOME/aur_helpers/"
	echo -e "\nScript interrupted. Exiting..."
	exit 1
}
trap cleanup SIGINT

###############################################################################
# Installing Base Packages
###############################################################################

while [[ true ]]; do
	read -p "Do you want to install packages: base-devel and git with pacman?
(y/N): " packages

	packages=${packages:-n}
	case "$packages" in
	[Yy]*)
		sudo pacman -S --needed base-devel git firefox
		break
		;;
	[Nn]*)
		echo "Alright."
		break
		;;
	*)
		echo "Enter a correct choice"
		;;
	esac
done

###############################################################################
# Installing Additional Packages
###############################################################################

install_additional_packages() {
	while [[ true ]]; do
		read -p "Would you like to install packages required for setting up your
desktop environment (i3) as well as apps like discord and OBS studio?
Warning: this may take a while if you don't have obs-studio-tytan652.
(y/N): " additional_packages
		additional_packages=${additional_packages:-n}
		case "$additional_packages" in
		[Yy]*)
			echo "Alright."
			return 0
			;;
		[Nn]*)
			echo "Alright."
			return 1
			;;
		*)
			echo "Enter a valid option..."
			;;
		esac
	done
}

while [[ true ]]; do

	read -p \
		"Select your AUR helper. [Default: none] (Won't reinstall if it exists)
1 - paru
2 - yay
Choice: " aur_helper

	aur_helper=${aur_helper:-0}
	case "$aur_helper" in
	1)
		if ! command -v paru >/dev/null 2>&1; then
			echo "Installing rustup instead of normal rust."
			sudo pacman -S --needed rustup

			mkdir -p "$HOME/aur_helpers/paru/"

			cd "$HOME/aur_helpers/paru/"

			git clone https://aur.archlinux.org/paru.git && cd paru

			makepkg -si

			rm -rf "$HOME/aur_helpers/"
		else
			echo "Paru is already installed."
			install_additional_packages
		fi

		if [[ install_additional_packages ]]; then
			echo "Installing zoxide, vim, sddm, neovim, btop, i3wm, kitty terminal,
jetbrains and noto fonts, feh, obs-studio-tytan652, vencord,
pavucontrol, spotify, lutris, fcitx5, vesktop (custom discord client),
thunar, maim, xclip, stow, wofi, waybar"

			paru -S --needed zoxide vim sddm neovim btop i3 kitty \
				ttf-jetbrains-mono-nerd noto-fonts-emoji feh \
				obs-studio-tytan652 vencord-desktop-git pavucontrol spotify \
				lutris fcitx5 thunar maim xclip stow wofi waybar
		fi

		break
		;;
	2)
		if ! command -v yay >/dev/null 2>&1; then
			mkdir -p "$HOME/aur_helpers/yay/"

			cd "$HOME/aur_helpers/yay/"

			git clone https://aur.archlinux.org/yay.git && cd yay

			makepkg -si

			rm -rf "$HOME/aur_helpers/"
		else
			echo "Yay is already installed."
			install_additional_packages
		fi

		if [[ install_additional_packages ]]; then
			echo "Installing zoxide, vim, sddm, neovim, btop, i3wm, kitty terminal,
jetbrains and noto fonts, feh, obs-studio-tytan652, vencord,
pavucontrol, spotify, lutris, fcitx5, vesktop (custom discord client),
thunar, maim, xclip, stow, wofi, waybar"

			yay -S --needed zoxide vim sddm neovim btop i3 kitty \
				ttf-jetbrains-mono-nerd noto-fonts-emoji feh \
				obs-studio-tytan652 vencord-desktop-git pavucontrol spotify \
				lutris fcitx5 thunar maim xclip stow wofi waybar
		fi

		break
		;;
	*)
		read -p "Are you sure you don't want an AUR helper? (y/N): " no_aur_helper
		case "$no_aur_helper" in
		[Yy]*)
			break
			;;
		*)
			echo "Going back..."
			;;
		esac
		;;
	esac
done

###############################################################################
# Terminal install
###############################################################################

while [[ true ]]; do
	read -p "If this is a terminal install. Would you like to enable SDDM?
(y/N): " enable_sddm
	enable_sddm=${enable_sddm:-n}
	case "$enable_sddm" in
	[Yy]*)
		sudo systemctl enable sddm --now
		;;
	[Nn]*)
		break
		;;
	*)
		echo "Select (y/n)."
		;;
	esac
done

###############################################################################
# GNU stow setup
###############################################################################
while [[ true ]]; do
	read -p "Would you like to setup GNU stow with the current repo dotfiles?
(Y/n): " setup_stow
	setup_stow=${setup_stow:-y}
	case "$enable_sddm" in
	[Yy]*)
		exec ./stow_setup.sh
		;;
	[Nn]*)
		break
		;;
	*)
		echo "Select (y/n)."
		;;
	esac
done