#!/bin/bash

# List available backups
echo "Available backups:"
ls -1 ~/backup-project/backups

# Ask user which backup to restore
read -p "Enter backup filename to restore: " BACKUP_FILE

# Log the recovery operation
echo "[$(date)] Starting recovery of $BACKUP_FILE..." >> ~/backup-project/logs/backup.log

# Check if backup file exists
if [ -f ~/backup-project/backups/$BACKUP_FILE ]; then
    # Perform the recovery
    tar -xzf ~/backup-project/backups/$BACKUP_FILE -C ~/backup-project/data

    if [ $? -eq 0 ]; then
        echo "[$(date)] Recovery successful" >> ~/backup-project/logs/backup.log
    else
        echo "[$(date)] Recovery failed" >> ~/backup-project/logs/backup.log
    fi
else
    echo "[$(date)] Error: Backup file not found" >> ~/backup-project/logs/backup.log
fi
