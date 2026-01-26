#!/bin/bash
set -e

echo "Starting application server setup..."

sudo apt update
sudo apt install -y python3 python3-venv python3-pip

cd ~/app

if [ ! -d "venv" ]; then
  python3 -m venv venv
  echo "Virtual environment created."
else
  echo "Virtual environment already exists."
fi

source venv/bin/activate
pip install -r requirements.txt

echo "Restarting Flask app..."
pkill -f "app.py" || true
sleep 1

nohup python3 app.py > flask.log 2>&1 &

echo "Flask app started in background. Check flask.log for logs."
echo "Application server setup completed."
