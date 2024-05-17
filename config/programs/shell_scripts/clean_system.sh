#!/bin/bash
###############################################################################
# A script to remove some cache, unused packages and duplicated files inside  #
#                          your home directory.                               #
###############################################################################

###############################################################################
# Remove the cached packages from your system.
###############################################################################
sudo pacman -Sc  # Package cache.
sudo pacman -Scc # All cached packages.

###############################################################################
# Remove unsused packages (Orphans)
###############################################################################
sudo pacman -Rns $(pacman -Qtdq)

###############################################################################
# Remove the cache from your home directory.
###############################################################################
rm -rf ~/.cache/*

###############################################################################
# Install and run an app that checks for duplicate files in the home directory.
###############################################################################
sudo pacman -S --needed rmlint
rmlint ~/
chmod +x rmlint.sh
./rmlint.sh # By default this script gets deleted afterwards.
