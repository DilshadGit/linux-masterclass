#!/usr/bin/env bash
# ==============================================================================
# 04_log_analyzer.sh - Production Web Server Log Parser (Awk & Grep)
# ==============================================================================
set -euo pipefail

LOG_FILE="${1:-/var/log/nginx/access.log}"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file $LOG_FILE not found. Creating simulated access log..."
    LOG_FILE="/tmp/simulated_access.log"
    cat << 'EOF' > "$LOG_FILE"
192.168.1.10 - - [25/Oct/2026:10:00:01 +0000] "GET /api/v1/users HTTP/1.1" 200 450
192.168.1.12 - - [25/Oct/2026:10:00:02 +0000] "POST /api/v1/auth HTTP/1.1" 401 120
192.168.1.10 - - [25/Oct/2026:10:00:05 +0000] "GET /api/v1/courses HTTP/1.1" 200 3200
10.0.0.5 - - [25/Oct/2026:10:00:06 +0000] "GET /admin HTTP/1.1" 403 90
192.168.1.10 - - [25/Oct/2026:10:00:10 +0000] "GET /api/v1/health HTTP/1.1" 500 80
192.168.1.15 - - [25/Oct/2026:10:00:12 +0000] "GET /index.html HTTP/1.1" 200 1500
EOF
fi

echo "======================================================"
echo "               HTTP LOG ANALYSIS REPORT               "
echo "Log source: $LOG_FILE"
echo "======================================================"

echo -e "\n[Top 5 Client IP Addresses]:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5

echo -e "\n[HTTP Response Status Code Breakdown]:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr

echo -e "\n[4xx Client Error Requests]:"
grep -E ' "(GET|POST|PUT|DELETE)[^"]*" 4[0-9]{2} ' "$LOG_FILE" | head -n 5 || echo "None"

echo -e "\n[5xx Server Error Requests]:"
grep -E ' "(GET|POST|PUT|DELETE)[^"]*" 5[0-9]{2} ' "$LOG_FILE" | head -n 5 || echo "None"
