#!/bin/bash

# Get current date and time for the backup file name
#DATE=$(date +%Y%m%d_%H%M%S)
#BACKUP_FILE="backup_${DATE}.tar.gz"

# Log the backup operation
#echo "[$(date)] Starting backup..." >> ~/backup-project/logs/backup.log

# Create the backup using tar
#tar -czf ~/backup-project/backups/$BACKUP_FILE -C ~/backup-project/data .

# Check if backup was successful
#if [ $? -eq 0 ]; then
 #   echo "[$(date)] Backup successful: $BACKUP_FILE" >> ~/backup-project/logs/backup.log
#else
 #   echo "[$(date)] Backup failed" >> ~/backup-project/logs/backup.log
#fi

#!/bin/bash

# Define the backup paths
LOG_DIR="/app/logs"
BACKUP_DIR="/app/backups"
DATA_DIR="/app/data"
LOG_FILE="$LOG_DIR/backup.log"

# Ensure that the required directories exist
mkdir -p $LOG_DIR $BACKUP_DIR $DATA_DIR

# Log start of the backup process
echo "Backup started at $(date)" >> $LOG_FILE

# Create a tar backup of the data directory
tar -czf $BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).tar.gz -C $DATA_DIR .

# Log completion of the backup process
echo "Backup completed at $(date)" >> $LOG_FILE

