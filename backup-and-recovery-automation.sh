#!/bin/bash

# backup-script.sh - Main backup script
#!/bin/bash

# Create required directories
mkdir -p ~/data           # Directory for source files
mkdir -p ~/backups        # Directory for backup files
mkdir -p ~/logs          # Directory for log files

# Create a log file
touch ~/logs/backup.log

# Backup script
cat << 'EOF' > ~/backup-script.sh
#!/bin/bash

# Get current date and time for the backup file name
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_${DATE}.tar.gz"

# Log the backup operation
echo "[$(date)] Starting backup..." >> ~/logs/backup.log

# Create the backup using tar
tar -czf ~/backups/$BACKUP_FILE -C ~/data .

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "[$(date)] Backup successful: $BACKUP_FILE" >> ~/logs/backup.log
else
    echo "[$(date)] Backup failed" >> ~/logs/backup.log
fi
EOF

# Recovery script
cat << 'EOF' > ~/recover-script.sh
#!/bin/bash

# List available backups
echo "Available backups:"
ls -1 ~/backups

# Ask user which backup to restore
read -p "Enter backup filename to restore: " BACKUP_FILE

# Log the recovery operation
echo "[$(date)] Starting recovery of $BACKUP_FILE..." >> ~/logs/backup.log

# Check if backup file exists
if [ -f ~/backups/$BACKUP_FILE ]; then
    # Perform the recovery
    tar -xzf ~/backups/$BACKUP_FILE -C ~/data

    if [ $? -eq 0 ]; then
        echo "[$(date)] Recovery successful" >> ~/logs/backup.log
    else
        echo "[$(date)] Recovery failed" >> ~/logs/backup.log
    fi
else
    echo "[$(date)] Error: Backup file not found" >> ~/logs/backup.log
fi
EOF

# Make scripts executable
chmod +x ~/backup-script.sh ~/recover-script.sh

# Add to crontab to run every day at midnight
(crontab -l 2>/dev/null; echo "0 0 * * * ~/backup-script.sh") | crontab -
