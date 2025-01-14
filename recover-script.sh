#!/bin/bash

# List available backups
#echo "Available backups:"
#ls -1 ~/backup-project/backups

# Ask user which backup to restore
#read -p "Enter backup filename to restore: " BACKUP_FILE

# Log the recovery operation
#echo "[$(date)] Starting recovery of $BACKUP_FILE..." >> ~/backup-project/logs/backup.log

# Check if backup file exists
#if [ -f ~/backup-project/backups/$BACKUP_FILE ]; then
    # Perform the recovery
 #   tar -xzf ~/backup-project/backups/$BACKUP_FILE -C ~/backup-project/data

   # if [ $? -eq 0 ]; then
    #    echo "[$(date)] Recovery successful" >> ~/backup-project/logs/backup.log
   # else
  #      echo "[$(date)] Recovery failed" >> ~/backup-project/logs/backup.log
 #   fi
#else
 #   echo "[$(date)] Error: Backup file not found" >> ~/backup-project/logs/backup.log
#fi


#!/bin/bash

# Define paths
LOG_DIR="/app/logs"
BACKUP_DIR="/app/backups"
DATA_DIR="/app/data"
LOG_FILE="$LOG_DIR/recovery.log"

# Ensure the required directories exist
mkdir -p $LOG_DIR $BACKUP_DIR $DATA_DIR

# Log start of the recovery process
echo "Recovery started at $(date)" >> $LOG_FILE

# Check if any backup files are available in the backups directory
BACKUP_FILE=$(ls -t $BACKUP_DIR/backup_*.tar.gz | head -n 1)

if [ -z "$BACKUP_FILE" ]; then
    echo "No backup found to restore." >> $LOG_FILE
    exit 1
fi

# Restore the backup
echo "Restoring backup from $BACKUP_FILE..." >> $LOG_FILE
tar -xzf $BACKUP_FILE -C $DATA_DIR

if [ $? -eq 0 ]; then
    echo "Recovery completed successfully at $(date)" >> $LOG_FILE
else
    echo "Recovery failed at $(date)" >> $LOG_FILE
    exit 1
fi
