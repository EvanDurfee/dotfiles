#!/bin/bash

set -euo pipefail


cat <<'EOF'
===================================================
Disable gnome keyring ssh-agent
===================================================
EOF

# Ensure profile is configured when running on a fresh system
if [ -z "${DOTFILES_PROFILE_LOADED:-}" ]; then . ~/.bash_profile; fi


# Mask the gnome keyring ssh-agent in favor of bitwarden
systemctl --user mask gcr-ssh-agent.socket
