#!/bin/bash

APP_DIR="/home/mstr/flask-proj/first/flask1"
LOGS="/home/mstr/flask_log"

if cd "$APP_DIR"; then
    source venv/bin/activate
    python3 app.py
else
    echo "Project directory not found!" >> $LOGS
    exit 1
fi
