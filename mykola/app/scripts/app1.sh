#!/bin/bash


APP_DIR="$1" 
LOGS="$2"

if cd "$APP_DIR"; then
    source venv/bin/activate
    python3 app.py
else
    echo "Project directory not found!" | tee -a "$LOGS"
    exit 1
fi
