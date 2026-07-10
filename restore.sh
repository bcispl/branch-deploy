#!/bin/bash
set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <backup_file>"
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: Backup file '$BACKUP_FILE' not found."
    exit 1
fi

echo "Restoring PostgreSQL backup: $BACKUP_FILE"

pg_restore \
  -U "$POSTGRES_USER" \
  -d "$POSTGRES_DB" \
  "$BACKUP_FILE"

echo "Restore completed successfully."
