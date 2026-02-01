#!/bin/bash

APP_DIR="$1"
VENV_DIR="$2"
LOGS="$3"

if cd "$APP_DIR"; then
  source "$VENV_DIR/bin/activate"
  python3 app.py 2>&1 | tee -a "$LOGS"
else
  echo "Project directory not found!" | tee -a "$LOGS"
  exit 1
fi
