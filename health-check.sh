#!/bin/bash

echo "================================="
echo "      DEVOPS HEALTH CHECK"
echo "================================="

echo ""
echo "Hostname: $(hostname)"
echo "User: $(whoami)"
echo "Date: $(date)"

echo ""
echo "===== Service Checks ====="

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
echo "===== Disk Usage ====="

disk_usage=$(df -h / | awk 'NR==2 {print $5}')

echo "Root filesystem usage: $disk_usage"
echo ""
echo "===== Memory Usage ====="

memory_usage=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

echo "Memory usage: $memory_usage%"
echo ""
echo "===== Network Check ====="

if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
    echo "Internet connectivity: OK"
else
    echo "Internet connectivity: FAILED"
fi
echo ""
echo "================================="
echo "        HEALTH CHECK COMPLETE"
echo "================================="

if [ "$failed" -eq 0 ]; then
    echo "Overall Status: HEALTHY ✅"
    exit 0
else
    echo "Overall Status: UNHEALTHY ❌"
    exit 1
fi
