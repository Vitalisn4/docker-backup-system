#!/bin/bash

# Get current date and time for the backup file name
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_${DATE}.tar.gz"

# Log the backup operation
echo "[$(date)] Starting backup..." >> ~/backup-project/logs/backup.log

# Create the backup using tar
tar -czf ~/backup-project/backups/$BACKUP_FILE -C ~/backup-project/data .

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "[$(date)] Backup successful: $BACKUP_FILE" >> ~/backup-project/logs/backup.log
else
    echo "[$(date)] Backup failed" >> ~/backup-project/logs/backup.log
fi


