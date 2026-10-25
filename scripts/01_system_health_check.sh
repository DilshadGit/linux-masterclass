#!/usr/bin/env bash
# ==============================================================================
# 01_system_health_check.sh - Production Server Health Audit
# ==============================================================================
set -euo pipefail

echo "======================================================"
echo "          PRODUCTION LINUX HEALTH MONITOR            "
echo "======================================================"
echo "Host: $(hostname -f 2>/dev/null || hostname)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Date: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
echo "======================================================"

echo -e "\n[1] CPU Load Average:"
uptime | awk -F'load average:' '{ print $2 }'

echo -e "\n[2] Memory Utilization:"
free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

echo -e "\n[3] Disk Space Utilization (Threshold > 80%):"
df -hP | awk '0+$5 >= 80 {print "CRITICAL: " $6 " is at " $5 " usage!"}' || true
df -h --total | tail -n 1

echo -e "\n[4] Top 5 Resource-Consuming Processes (CPU):"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6

echo -e "\n[5] Network Listening Ports:"
ss -tulpn | head -n 10

echo -e "\n[6] Failed systemd Units:"
systemctl --failed --no-pager || true

echo -e "\nAudit complete."
