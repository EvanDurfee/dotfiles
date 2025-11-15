#!/bin/bash

set -euo pipefail

# Initialize freedesktop-color-scheme-monitor symlinks
cat <<'EOF'
===================================================
Remove default .zsh profile
===================================================
EOF

rm -f "$HOME"/.zshrc "$HOME"/.zprofile
