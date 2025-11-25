#!/bin/bash

set -euo pipefail

# Remove default zshrc and zshprofile
cat <<'EOF'
===================================================
Remove default .zsh profile
===================================================
EOF

rm -f "$HOME"/.zshrc "$HOME"/.zprofile
