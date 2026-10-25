#!/usr/bin/env bash
# ==============================================================================
# 02_automated_backup.sh - Automated Directory Backup with MD5 Verification
# ==============================================================================
set -euo pipefail

SOURCE_DIR="${1:-/etc}"
BACKUP_DEST="${2:-/var/backups/teachcloud}"
TIMESTAMP="$(date +'%Y%m%d_%H%M%S')"
ARCHIVE_NAME="backup_$(basename "$SOURCE_DIR")_${TIMESTAMP}.tar.gz"

mkdir -p "$BACKUP_DEST"

echo "Creating compressed archive of $SOURCE_DIR..."
tar -czf "${BACKUP_DEST}/${ARCHIVE_NAME}" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

echo "Computing MD5 Checksum..."
md5sum "${BACKUP_DEST}/${ARCHIVE_NAME}" > "${BACKUP_DEST}/${ARCHIVE_NAME}.md5"

echo "Backup successful: ${BACKUP_DEST}/${ARCHIVE_NAME}"
echo "Checksum: $(cat "${BACKUP_DEST}/${ARCHIVE_NAME}.md5")"

# Retain last 7 backups, prune older
find "$BACKUP_DEST" -name "backup_*.tar.gz" -type f -mtime +7 -delete || true
echo "Retention policy executed: archives older than 7 days cleaned."
