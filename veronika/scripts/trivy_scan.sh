#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "Run as root"
  exit 1
fi

apt update -y

apt install -y wget gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
  > /etc/apt/sources.list.d/trivy.list
apt install -y trivy

mkdir -p /var/log/trivy
trivy fs / --format json > /var/log/trivy/trivy-report.json
