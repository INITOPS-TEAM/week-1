#!/bin/bash

APP_DIR="/home/mstr/flask2/first/flask2"
VENV_DIR="/home/mstr/flask2/first/venv"
LOGS="/home/mstr/flask_logs"

source "$VENV_DIR/bin/activate"

if cd "$APP_DIR"; then
    python3 app.py
else
    echo "Project not found!" >> $LOGS
    exit 1
fi
