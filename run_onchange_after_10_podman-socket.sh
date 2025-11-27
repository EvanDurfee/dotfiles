#!/bin/bash

set -euo pipefail

cat <<'EOF'
===================================================
Enable podman socket
===================================================
EOF
systemctl --user enable podman.socket
