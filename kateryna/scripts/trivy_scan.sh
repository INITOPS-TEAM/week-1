#!/bin/bash
set -e

REPORT_DIR="/var/security_reports"
sudo mkdir -p "$REPORT_DIR"

FILENAME="report-$(hostname)-$(date +%F_%T).json"

sudo trivy fs \
  --format json \
  --scanners vuln \
  / | sudo tee "$REPORT_DIR/$FILENAME" > /dev/null
