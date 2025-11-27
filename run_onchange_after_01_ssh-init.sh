#!/bin/bash

set -euo pipefail

# Initialize freedesktop-color-scheme-monitor symlinks
cat <<'EOF'
===================================================
Initialize .ssh/config
===================================================
EOF

# Ensure profile is configured when running on a fresh system
if [ -z "${DOTFILES_PROFILE_LOADED:-}" ]; then . ~/.bash_profile; fi

if [ -e "$HOME"/.ssh/config ]; then
	exit 0
fi

mkdir -p "$HOME"/.ssh
cat <<'EOF' | tee "$HOME"/.ssh/config >/dev/null
Host *
	ServerAliveInterval 60
	ServerAliveCountMax 240
# Host mymachine
# 	RequestTTY yes
# 	RemoteCommand zsh -l
EOF
