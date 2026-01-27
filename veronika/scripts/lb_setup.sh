#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/common.sh"
require_root

APP1_IP="${APP1_IP:-192.168.56.11}"
APP2_IP="${APP2_IP:-192.168.56.12}"
APP_PORT="${APP_PORT:-5000}"
LB_PORT="${LB_PORT:-80}"

log "Installing nginx..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y nginx curl

log "Writing nginx LB config (overwrites)..."
cat > /etc/nginx/conf.d/bird_lb.conf <<EOF
upstream bird_app {
    server ${APP1_IP}:${APP_PORT};
    server ${APP2_IP}:${APP_PORT};
}

server {
    listen ${LB_PORT};

    location / {
        proxy_pass http://bird_app;
        proxy_set_header Host \$host;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

nginx -t
systemctl enable --now nginx
systemctl reload nginx

log "Done. Test:"
log "  curl -I http://localhost/"
