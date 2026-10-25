#!/usr/bin/env bash
# ==============================================================================
# 03_user_provisioning.sh - Hardened DevOps User Creation Script
# ==============================================================================
set -euo pipefail

USERNAME="${1:-devops}"
PUBKEY="${2:-}"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." >&2
   exit 1
fi

if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists."
else
    echo "Creating user $USERNAME with /bin/bash shell..."
    useradd -m -s /bin/bash -G sudo "$USERNAME" || useradd -m -s /bin/bash -G wheel "$USERNAME"
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$USERNAME"
    chmod 0440 "/etc/sudoers.d/$USERNAME"
    echo "Sudo privileges granted to $USERNAME."
fi

USER_SSH="/home/$USERNAME/.ssh"
mkdir -p "$USER_SSH"
chmod 700 "$USER_SSH"

if [[ -n "$PUBKEY" ]]; then
    echo "$PUBKEY" >> "$USER_SSH/authorized_keys"
    chmod 600 "$USER_SSH/authorized_keys"
    chown -R "$USERNAME:$USERNAME" "$USER_SSH"
    echo "SSH Public Key installed for $USERNAME."
fi
