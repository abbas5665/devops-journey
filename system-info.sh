#!/bin/bash

echo "===== System Information ====="
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "IP Address:"
hostname -I
