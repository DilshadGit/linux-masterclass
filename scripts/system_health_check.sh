#!/usr/bin/env bash
# Production Linux System Health Diagnostic Script
set -euo pipefail

echo "=========================================="
echo "Linux Health Audit - $(date)"
echo "Host: $(hostname) | Kernel: $(uname -r)"
echo "=========================================="

echo "[1] Uptime & Load Average:"
uptime

echo -e "\n[2] Memory Utilization:"
free -h

echo -e "\n[3] Disk Space Usage:"
df -h -x tmpfs -x devtmpfs

echo -e "\n[4] Top 5 Memory Consuming Processes:"
ps aux --sort=-%mem | head -n 6

echo -e "\n[5] Active Listening TCP/UDP Ports:"
ss -tulpn | head -n 15

echo -e "\nAudit complete."
