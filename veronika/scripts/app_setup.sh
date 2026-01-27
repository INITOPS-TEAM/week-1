!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
source "${SCRIPT_DIR}/common.sh"
require_root

APP_SRC="${REPO_ROOT}/veronika/app"
APP_DIR="/opt/birdapp"
APP_USER="birdapp"
SERVICE_NAME="birdapp"

log "Installing packages..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y python3 python3-venv python3-pip rsync curl

log "Creating service user if needed..."
id "${APP_USER}" >/dev/null 2>&1 || useradd --system --create-home --shell /usr/sbin/nologin "${APP_USER}"

log "Validating source..."
test -f "${APP_SRC}/app.py" || { echo "Missing ${APP_SRC}/app.py"; exit 1; }
test -f "${APP_SRC}/requirements.txt" || { echo "Missing ${APP_SRC}/requirements.txt (must include flask)"; exit 1; }

log "Syncing app to ${APP_DIR} (overwrites target)..."
mkdir -p "${APP_DIR}"
rsync -a --delete "${APP_SRC}/" "${APP_DIR}/"
chown -R "${APP_USER}:${APP_USER}" "${APP_DIR}"

log "Setting up venv + dependencies..."
if [[ ! -d "${APP_DIR}/venv" ]]; then
  sudo -u "${APP_USER}" python3 -m venv "${APP_DIR}/venv"
fi
sudo -u "${APP_USER}" "${APP_DIR}/venv/bin/pip" install --upgrade pip
sudo -u "${APP_USER}" "${APP_DIR}/venv/bin/pip" install -r "${APP_DIR}/requirements.txt"

log "Writing systemd unit (overwrites existing)..."
cat > "/etc/systemd/system/${SERVICE_NAME}.service" <<EOF
[Unit]
Description=Bird Flask App
After=network.target

[Service]
User=${APP_USER}
WorkingDirectory=${APP_DIR}
Environment=PYTHONUNBUFFERED=1
ExecStart=${APP_DIR}/venv/bin/python3 ${APP_DIR}/app.py
Restart=always
RestartSec=2

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now "${SERVICE_NAME}"

log "Done. Check:"
log "  systemctl status ${SERVICE_NAME}"
log "  journalctl -u ${SERVICE_NAME} -n 50 --no-pager"
