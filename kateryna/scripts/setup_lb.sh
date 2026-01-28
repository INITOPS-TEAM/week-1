#!/bin/bash
set -e

echo "Starting Load Balancer setup..."

sudo apt update
sudo apt install -y nginx

cat <<EOF | sudo tee /etc/nginx/sites-available/flask_app
upstream flask_app {
    server 192.168.56.102:5000;
    server 192.168.56.103:5000;
}

server {
    listen 80;

    location / {
        proxy_pass http://flask_app;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/flask_app /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

sudo nginx -t
sudo systemctl restart nginx

echo "Load Balancer setup completed successfully."
