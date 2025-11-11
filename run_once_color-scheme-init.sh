#!/bin/bash

set -euo pipefail

# Initialize freedesktop-color-scheme-monitor symlinks

# bat
if ! [ -e "${XDG_CONFIG_HOME:-"$HOME"/.config}"/bat/config ]; then
	echo Initializing bat color scheme
	ln -rs "${XDG_CONFIG_HOME:-"$HOME"/.config}"/bat/dark-theme.config "${XDG_CONFIG_HOME:-"$HOME"/.config}"/bat/config
fi

# git delta
if ! [ -e "${XDG_CONFIG_HOME:-"$HOME"/.config}"/git/system-theme.config ]; then
	echo Initializing git-delta color scheme
	ln -rs "${XDG_CONFIG_HOME:-"$HOME"/.config}"/git/dark-theme.config "${XDG_CONFIG_HOME:-"$HOME"/.config}"/git/system-theme.config
fi

# exa / eza
if ! [ -e "${XDG_CONFIG_HOME:-"$HOME"/.config}"/exa/colors.config ]; then
	echo Initializing eza color scheme
	ln -rs "${XDG_CONFIG_HOME:-"$HOME"/.config}"/exa/colors-dark.config "${XDG_CONFIG_HOME:-"$HOME"/.config}"/exa/colors.config
fi

# kitty
if ! [ -e "${XDG_CONFIG_HOME:-"$HOME"/.config}"/kitty/system-theme.conf ]; then
	echo Initializing kitty color scheme
	ln -rs "${XDG_CONFIG_HOME:-"$HOME"/.config}"/kitty/dark-theme.conf "${XDG_CONFIG_HOME:-"$HOME"/.config}"/kitty/system-theme.conf
fi
