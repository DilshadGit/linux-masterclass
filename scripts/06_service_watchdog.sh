#!/usr/bin/env bash
# ==============================================================================
# 06_service_watchdog.sh - Automated Service Daemon Watchdog
# ==============================================================================
set -euo pipefail

SERVICE_NAME="${1:-teachcloud-backend}"

if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "Service $SERVICE_NAME is HEALTHY (running)."
else
    echo "ALERT: Service $SERVICE_NAME is DOWN! Attempting auto-recovery..."
    systemctl restart "$SERVICE_NAME"
    sleep 2
    if systemctl is-active --quiet "$SERVICE_NAME"; then
        echo "SUCCESS: Service $SERVICE_NAME was restarted successfully."
    else
        echo "CRITICAL: Service $SERVICE_NAME restart failed! Sending alert..." >&2
        # logger or notification webhook here
        exit 2
    fi
fi
