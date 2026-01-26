#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-http://localhost/}"
echo "Testing: ${TARGET}"
curl -sS -I "${TARGET}" | head -n 10
echo
curl -sS "${TARGET}" | head -n 30
