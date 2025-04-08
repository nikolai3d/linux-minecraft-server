#!/bin/bash

# === CONFIG ===
BEDROCK_DIR="/root/bedrock"
BACKUP_DIR="/root/bedrock_backups"
WORLD_NAME="worlds"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="bedrock_backup_$TIMESTAMP.tar.gz"
LOG_FILE="/root/bedrock_logs/world_backup.log"
SCREEN_NAME="nikolai-bedrock"

echo "[`date`] Starting Bedrock world backup..." >> "$LOG_FILE"

# === CREATE BACKUP FOLDER IF NEEDED ===
mkdir -p "$BACKUP_DIR"

# === SAVE WORLD STATE ===
echo "[`date`] Sending save hold..." >> "$LOG_FILE"
screen -S "$SCREEN_NAME" -p 0 -X stuff "save hold$(printf \\r)"
sleep 2

echo "[`date`] Sending save query..." >> "$LOG_FILE"
screen -S "$SCREEN_NAME" -p 0 -X stuff "save query$(printf \\r)"
sleep 2

echo "[`date`] Sending save resume..." >> "$LOG_FILE"
screen -S "$SCREEN_NAME" -p 0 -X stuff "save resume$(printf \\r)"
sleep 2

# === CREATE BACKUP ===
echo "[`date`] Creating backup: $BACKUP_NAME" >> "$LOG_FILE"
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$BEDROCK_DIR" "$WORLD_NAME"

# === CLEANUP OLD BACKUPS ===
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +180 -exec rm {} \;

echo "[`date`] Backup complete ✅" >> "$LOG_FILE"
