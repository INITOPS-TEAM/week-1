#!/bin/bash

echo "Verifying Flask application..."

APP_URL="http://localhost:5000"

if curl -s --fail "$APP_URL" > /dev/null; then
  echo "Flask application is running and reachable on port 5000"
else
  echo "ERROR: Flask application is not reachable on port 5000"
  exit 1
fi

