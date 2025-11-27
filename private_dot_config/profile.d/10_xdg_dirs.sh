export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Try to make programs follow the XDF directory spec
# Check here for updates: https://wiki.archlinux.org/index.php/XDG_Base_Directory

# anaconda (python)
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"

# Anki
# Anki is natively supported now, according to https://apps.ankiweb.net/docs/manual20.html#file-locations

# Ansible
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
# The remote's ~/.ansible/tmp can be moved by setting remote_tmp = ${XDG_CONFIG_HOME}/ansible/tmp in an appropriate ansible.cfg.

# Atom
export ATOM_HOME="$XDG_DATA_HOME"/atom

# AWS cli
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

# Azure cli
export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure

# Bash Completion
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion

# Ruby bundler
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

# Rust cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# Conky
# Conky is natively supported now

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# DotNet
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"

# FFmpeg
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg

# GDB
#if which gdb >/dev/null 2>&1; then
#	gdb () {
#		"$(which gdb)" -nh -x "$XDG_CONFIG_HOME"/gdb/init "$@"
#	}
#}

# GnupPG
# Also requires modifying systemd unit files
# export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# mkdir -p "$GNUPGHOME"

# GoLang
# GOPATH is largely replaced by go modules, but is still a fallback
export GOPATH="$XDG_DATA_HOME"/go
# GO build cache (defaults to $XDG_CACHE_HOME/go-build)
export GOCACHE="$XDG_CACHE_HOME"/go/build
# GO module cache (defaults to $GOPATH/pkg)
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
# GO binary install dir (defaults to $GOPATH/bin)
export GOBIN="$HOME/.local/bin"
mkdir -p "$GOPATH" "$GOCACHE" "$GOMODCACHE" "$GOBIN"

# Gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# GTK
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# Java (OpenJDK)
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# KDE
# Broken support post-kde 4
# export KDEHOME="$XDG_CONFIG_HOME"/kde

# Kodi
export KODI_DATA="$XDG_DATA_HOME/kodi"

# Kubectl
export KUBECONFIG="$XDG_CONFIG_HOME"/kube/config
export KUBECACHEDIR="$XDG_CACHE_HOME"/kube

# Less
mkdir -p "$XDG_CACHE_HOME"/less
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export LESSKEY="$XDG_DATA_HOME/less/lesskey"

# LibX11
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose

# JetBrains
# Set the VMOPTIONS to a static location instead of per-IDE and version
export CLION_VM_OPTIONS="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/jetbrains64.vmoptions
export CLION_PROPERTIES="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/idea.properties
export DATAGRIP_VM_OPTIONS="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/jetbrains64.vmoptions
export DATAGRIP_PROPERTIES="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/idea.properties
export IDEA_VM_OPTIONS="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/jetbrains64.vmoptions
export IDEA_PROPERTIES="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/idea.properties
export GOLAND_VM_OPTIONS="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/jetbrains64.vmoptions
export GOLAND_PROPERTIES="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/idea.properties
export PYCHARM_VM_OPTIONS="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/jetbrains64.vmoptions
export PYCHARM_PROPERTIES="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/idea.properties
export RIDER_VM_OPTIONS="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/jetbrains64.vmoptions
export RIDER_PROPERTIES="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/idea.properties
export RUBYMINE_VM_OPTIONS="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/jetbrains64.vmoptions
export RUBYMINE_PROPERTIES="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/idea.properties
export RUSTROVER_VM_OPTIONS="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/jetbrains64.vmoptions
export RUSTROVER_PROPERTIES="${XDG_CONFIG_HOME:-"$HOME"/.config}"/JetBrains/idea.properties

# Maven
# More work than it's worth to change (other apps may still use .m2 anyway)
# Cannot be set via env; requires the settings flag and the following settings:
# <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
#       xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">
# <localRepository>${env.XDG_DATA_HOME}/maven</localRepository>
# </settings>
# if which mvn >/dev/null 2>&1; then
# 	mvn () {
# 		"$(which mvn)" -gs "$XDG_CONFIG_HOME"/maven/settings.xml
# 	}
# }

# Minio Client
export MC_CONFIG_DIR="$XDG_CONFIG_HOME"/minio-client

# MyPy
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy

# NodeJS
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

# npm
# Requires the following npmrc content:
# prefix=${XDG_DATA_HOME}/npm
# cache=${XDG_CACHE_HOME}/npm
# tmp=${XDG_RUNTIME_DIR}/npm
# init-module=${XDG_CONFIG_HOME}/npm/config/npm-init.js
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

# Nuget
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# NVM
export NVM_DIR="$XDG_DATA_HOME"/nvm

# parallel
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel

# pass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"

# PostgresQL
mkdir -p "$XDG_CONFIG_HOME/pg"
mkdir -p "$XDG_CACHE_HOME/pg"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

# PyEnv
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv

# Python
export PYTHON_HISTORY="$XDG_STATE_HOME"/python_history
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME"/python
export PYTHONUSERBASE="$XDG_DATA_HOME"/python
mkdir -p "$PYTHONPYCACHEPREFIX" "$PYTHONUSERBASE"

# Python pylint
export PYLINTHOME="$XDG_CACHE_HOME"/pylint

# Python setuptools
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME"/python-eggs

# GNU Readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Redis
export REDISCLI_RCFILE="$XDG_CONFIG_HOME"/redis/redisclirc
export REDISCLI_HISTFILE="$XDG_STATE_HOME"/redis/rediscli_history

# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/config

# Ruby Gems
# Auto-generates a gemrc to set the bin dir to $XDG_DATA_HOME/gem/bin
# XDG_DATA_HOME must not contain spaces
export GEMRC="$XDG_CONFIG_HOME"/gemrc
export GEM_HOME="$XDG_DATA_HOME"/gem
export PATH="$PATH:$GEM_HOME/bin"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
if ! [ -e "$XDG_CONFIG_HOME"/gemrc ]; then
	echo "gem: --bindir $GEM_HOME/bin" > "$GEMRC"
fi

# Rust up
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# SBT
# more work than it's worth to fix, due to dependent tools

# GNU Screen
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export SCREENDIR="${XDG_RUNTIME_DIR:-/run/user/$UID}"/screen

# Teamspeak
# Disabled to avoid breaking flatpak installations
# export TS3_CONFIG_DIR="$XDG_CONFIG_HOME/ts3client"

# vale
#if which vale >/dev/null 2>&1; then
#	vale () {
#		"$(which vale)" --config "$XDG_CONFIG_HOME/vale/config.ini" "$@"
#	}
#}

# Vim (requires specific content in VIMRC, see the wiki)
export VIMINIT='source "$XDG_CONFIG_HOME/vim/vimrc"'

# wget
# Add to wgetrc: hsts-file="$XDG_CACHE_HOME"/wget-hsts
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# Wine
mkdir -p "$XDG_DATA_HOME"/wineprefixes
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

# ZSH
# Should be done in ~/.zshenv instead, since it is first in the load order
# export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
