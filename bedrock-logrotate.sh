#!/bin/bash

LOG_DIR="/root/bedrock_logs"
ARCHIVE_DIR="$LOG_DIR/archive"
DATE=$(date +%F) # e.g., 2025-04-07

mkdir -p "$ARCHIVE_DIR"

# Move and rename the current log
if [ -f "$LOG_DIR/latest.log" ]; then
    mv "$LOG_DIR/latest.log" "$ARCHIVE_DIR/daily-$DATE.log"
    gzip "$ARCHIVE_DIR/daily-$DATE.log"
fi

# Recreate empty log file for server
touch "$LOG_DIR/latest.log"
chown root:root "$LOG_DIR/latest.log"
chmod 644 "$LOG_DIR/latest.log"

# Clean up compressed logs older than 180 days
find "$ARCHIVE_DIR" -type f -name "*.log.gz" -mtime +180 -delete

