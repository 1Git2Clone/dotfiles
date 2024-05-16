#!/bin/bash

stow home_user/ -t "$HOME/"
stow config/ -t "$HOME/.config/"
stow cargo/ -t "$HOME/.cargo/"
