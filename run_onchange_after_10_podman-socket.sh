#!/bin/bash

set -euo pipefail

cat <<'EOF'
===================================================
Enable podman socket
===================================================
EOF

systemctl --user enable podman.socket || echo 'Podman socket enable failed, is it installed?' >&2
