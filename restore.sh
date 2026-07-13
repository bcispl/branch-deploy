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

# Copy backup into the postgres container
docker cp "$BACKUP_FILE" postgres:/tmp/restore.backup

# Restore inside the postgres container
docker exec postgres pg_restore \
    --clean \
    --if-exists \
    --no-owner \
    --no-privileges \
    -U "$POSTGRES_USER" \
    -d "$POSTGRES_DB" \
    /tmp/restore.backup

echo "Restore completed successfully."
