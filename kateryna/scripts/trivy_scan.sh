#!/bin/bash

REPORT_DIR="/var/security_reports"
sudo mkdir -p "$REPORT_DIR"
sudo chmod 755 "$REPORT_DIR"

if ! command -v trivy &> /dev/null; then
  sudo apt-get update
  sudo apt-get install -y wget apt-transport-https gnupg lsb-release
  wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
  echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/trivy.list
  sudo apt-get update
  sudo apt-get install -y trivy
fi

FILENAME="report-$(hostname)-$(date +%F_%T).json"
sudo trivy fs --format json --security-checks vuln / | sudo tee "$REPORT_DIR/$FILENAME" > /dev/null

