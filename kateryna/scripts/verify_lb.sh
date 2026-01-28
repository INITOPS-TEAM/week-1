#!/bin/bash

echo "Verifying Load Balancer..."

LB_URL="http://localhost"

if curl -s --fail "$LB_URL" > /dev/null; then
  echo "OK: Load balancer is running and proxying requests"
else
  echo "ERROR: Load balancer is not responding"
  exit 1
fi

