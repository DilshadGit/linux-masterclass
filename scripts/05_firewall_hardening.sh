#!/usr/bin/env bash
# ==============================================================================
# 05_firewall_hardening.sh - Production Linux UFW & Iptables Hardening
# ==============================================================================
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
   echo "Root privileges required." >&2
   exit 1
fi

echo "Configuring Uncomplicated Firewall (UFW) baseline..."
if command -v ufw &>/dev/null; then
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow 22/tcp comment 'SSH Secure'
    ufw allow 80/tcp comment 'HTTP'
    ufw allow 443/tcp comment 'HTTPS'
    ufw limit 22/tcp comment 'Rate limit SSH brute force'
    echo "Enabling UFW..."
    ufw --force enable
    ufw status verbose
else
    echo "UFW not found. Setting raw iptables rules..."
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT
    echo "Raw iptables baseline configured."
fi
