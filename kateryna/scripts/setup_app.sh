#!/bin/bash
set -e

APP_DIR="$HOME/app"
VENV_DIR="$APP_DIR/venv"
REQUIREMENTS_FILE="requirements.txt"
SERVICE_NAME="flask-app"
SERVICE_SRC="$HOME/scripts/flask-app.service"
SERVICE_DST="/etc/systemd/system/${SERVICE_NAME}.service"

echo "Starting application server setup..."

sudo apt update
sudo apt install -y python3 python3-venv python3-pip

cd "$APP_DIR"

if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv "$VENV_DIR"
  echo "Virtual environment created."
else
  echo "Virtual environment already exists."
fi

source "$VENV_DIR/bin/activate"
pip install -r "$REQUIREMENTS_FILE"

echo "Python environment ready."

echo "Installing systemd service..."

sudo cp "$SERVICE_SRC" "$SERVICE_DST"

sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl restart "$SERVICE_NAME"

echo "Application server setup completed."
systemctl status "$SERVICE_NAME" --no-pager
