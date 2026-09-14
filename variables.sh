#!/bin/bash

echo "===== DevOps Service Health Check ====="

services=("ssh" "cron" "docker")

running=0
failed=0

for service in "${services[@]}"; do
    echo ""
    echo "Checking $service..."

    if systemctl is-active --quiet "$service"; then
        echo "STATUS: $service is running."
        ((running++))
    else
        echo "STATUS: $service is NOT running."
        ((failed++))
    fi
done

echo ""
echo "===== Summary ====="
echo "Running services: $running"
echo "Failed services: $failed"

if [ "$failed" -eq 0 ]; then
    exit 0
else
    exit 1
fi
