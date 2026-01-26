#!/usr/bin/env bash
set -euo pipefail

log() { echo "[$(date -Is)] $*"; }

require_root() {
  if [[ "${EUID}" -ne 0 ]]; then
    echo "Run with sudo." >&2
    exit 1
  fi
}
