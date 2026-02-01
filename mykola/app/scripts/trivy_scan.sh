#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H-%M")
REPORT_DIR="$HOME/trivy_reports"
REPORT_FILE="trivy_scanning$DATE.json"

mkdir -p "$REPORT_DIR"

sudo trivy fs / \
  --scanners vuln \
  --skip-dirs /snap \
  --severity MEDIUM,LOW \
  --format json \
  | tee "$REPORT_DIR/$REPORT_FILE"