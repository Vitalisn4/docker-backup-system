# docker-backup-system
Creating an automated backup and recovery system using tar and cronjob

# Backup and Recovery Automation System Documentation
### Technical Documentation and Implementation Guide
#### Version 1.0

## Table of Contents
1. System Overview
2. Directory Structure
3. Components
4. Script Analysis
5. Implementation Guide
6. Automation Details
7. Usage Instructions
8. Troubleshooting
9. Technical Reference

## 1. System Overview

The Backup and Recovery Automation System is a robust solution designed to automatically backup data files and provide a straightforward recovery mechanism. The system utilizes bash scripting, the tar utility for compression, and cron for scheduling automatic backups.

### Key Features:
- Automated daily backups
- Compressed archive creation
- Detailed logging system
- Interactive recovery process
- Simple yet robust error handling

## 2. Directory Structure

```
~/backup-project/
├── data/           # Source data directory
├── backups/        # Backup archives storage
├── logs/           # System logs
├── backup-script.sh    # Backup automation script
└── recover-script.sh   # Recovery automation script
```

## 3. Components

### 3.1 Core Components
1. **backup-script.sh**: Primary script for creating backups
2. **recover-script.sh**: Script for restoring data from backups
3. **logs/backup.log**: System activity log file
4. **cron job**: Automated scheduling component

### 3.2 Supporting Components
1. Directory structure
2. File permissions
3. Logging mechanism
4. Error handling system

## 4. Script Analysis

### 4.1 Backup Script (backup-script.sh)

```bash
#!/bin/bash

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_${DATE}.tar.gz"

echo "[$(date)] Starting backup..." >> ~/backup-project/logs/backup.log

tar -czf ~/backup-project/backups/$BACKUP_FILE -C ~/backup-project/data .

if [ $? -eq 0 ]; then
    echo "[$(date)] Backup successful: $BACKUP_FILE" >> ~/backup-project/logs/backup.log
else
    echo "[$(date)] Backup failed" >> ~/backup-project/logs/backup.log
fi
```

#### Line-by-Line Analysis:

1. **Shebang Line**:
   ```bash
   #!/bin/bash
   ```
   - Indicates this is a bash script
   - `/bin/bash` specifies the interpreter path

2. **Date Generation**:
   ```bash
   DATE=$(date +%Y%m%d_%H%M%S)
   ```
   - Creates timestamp using format:
     - %Y: Four-digit year
     - %m: Two-digit month (01-12)
     - %d: Two-digit day (01-31)
     - %H: Hour (00-23)
     - %M: Minutes (00-59)
     - %S: Seconds (00-59)

3. **Backup Filename Creation**:
   ```bash
   BACKUP_FILE="backup_${DATE}.tar.gz"
   ```
   - Creates unique filename using timestamp
   - .tar.gz extension indicates tar archive with gzip compression

4. **Logging Start**:
   ```bash
   echo "[$(date)] Starting backup..." >> ~/backup-project/logs/backup.log
   ```
   - `>>`: Append operator
   - `$(date)`: Current timestamp
   - Logs start of backup process

5. **Backup Creation**:
   ```bash
   tar -czf ~/backup-project/backups/$BACKUP_FILE -C ~/backup-project/data .
   ```
   - tar flags:
     - `-c`: Create archive
     - `-z`: Use gzip compression
     - `-f`: Specify filename
     - `-C`: Change to directory

### 4.2 Recovery Script (recover-script.sh)

```bash
#!/bin/bash

echo "Available backups:"
ls -1 ~/backup-project/backups

read -p "Enter backup filename to restore: " BACKUP_FILE

echo "[$(date)] Starting recovery of $BACKUP_FILE..." >> ~/backup-project/logs/backup.log

if [ -f ~/backup-project/backups/$BACKUP_FILE ]; then
    tar -xzf ~/backup-project/backups/$BACKUP_FILE -C ~/backup-project/data
    
    if [ $? -eq 0 ]; then
        echo "[$(date)] Recovery successful" >> ~/backup-project/logs/backup.log
    else
        echo "[$(date)] Recovery failed" >> ~/backup-project/logs/backup.log
    fi
else
    echo "[$(date)] Error: Backup file not found" >> ~/backup-project/logs/backup.log
fi
```

#### Line-by-Line Analysis:

1. **Backup Listing**:
   ```bash
   ls -1 ~/backup-project/backups
   ```
   - `-1`: List one file per line
   - Shows available backups

2. **User Input**:
   ```bash
   read -p "Enter backup filename to restore: " BACKUP_FILE
   ```
   - `-p`: Display prompt
   - Stores input in BACKUP_FILE variable

3. **File Verification**:
   ```bash
   if [ -f ~/backup-project/backups/$BACKUP_FILE ]; then
   ```
   - `-f`: Test if file exists
   - Ensures backup exists before attempting recovery

## 5. Implementation Guide

### 5.1 Initial Setup
```bash
# Create project structure
mkdir -p ~/backup-project/{data,backups,logs}
touch ~/backup-project/logs/backup.log

# Create scripts
touch ~/backup-project/backup-script.sh
touch ~/backup-project/recover-script.sh

# Set permissions
chmod +x ~/backup-project/*.sh
```

### 5.2 Cron Job Setup
```bash
# Open crontab editor
crontab -e

# Add daily backup at midnight
0 0 * * * ~/backup-project/backup-script.sh
```

## 6. Automation Details

### 6.1 Cron Schedule Format
```
0 0 * * * ~/backup-project/backup-script.sh
│ │ │ │ │
│ │ │ │ └── Day of week (0-6, Sunday=0)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

## 7. Usage Instructions

### 7.1 Manual Backup
```bash
./backup-script.sh
```

### 7.2 Recovery Process
```bash
./recover-script.sh
```

### 7.3 Monitoring
```bash
# View logs
cat ~/backup-project/logs/backup.log

# List backups
ls -l ~/backup-project/backups/
```

## 8. Troubleshooting

### 8.1 Common Issues and Solutions

1. **Script Won't Execute**
   - Check permissions: `chmod +x script.sh`
   - Verify path: `pwd`

2. **Cron Job Not Running**
   - Check cron logs: `grep CRON /var/log/syslog`
   - Verify cron service: `service cron status`

3. **Backup Failed**
   - Check disk space: `df -h`
   - Verify directory permissions: `ls -la`

## 9. Technical Reference

### 9.1 Common Symbols and Operators
- `$()`: Command substitution
- `>>`: Append to file
- `>`: Write to file (overwrite)
- `~/`: Home directory
- `.`: Current directory
- `$?`: Exit status of last command
- `-eq`: Numerical equality comparison
- `-f`: File exists test

### 9.2 Important Commands
- `tar`: Archive utility
- `date`: Date and time handling
- `echo`: Output text
- `read`: Get user input
- `chmod`: Change file permissions
- `mkdir`: Create directory
- `ls`: List directory contents

This documentation provides a comprehensive overview of the Backup and Recovery Automation System, including detailed explanations of all components, implementation instructions, and technical references for future maintenance and troubleshooting.

# Setting Up a Docker Container with Mock Data Files
## Documentation

### Overview
This document provides detailed instructions for setting up a Docker container system that manages mock data files with automated backup capabilities. The system includes mock data generation, backup scheduling, and recovery procedures.

### Prerequisites
- Docker installed on your machine
- Docker Compose installed
- Basic knowledge of command line operations
- Text editor (e.g., nano, vim, or VS Code)

### System Architecture
The setup creates a containerized environment with:
- Ubuntu 22.04 base image
- Automated backup system using cron
- Volume mapping for persistent storage
- Mock data management capabilities
- Backup and recovery scripts

### Directory Structure
```
docker-backup-system/
├── backup-script.sh
├── recover-script.sh
├── docker-compose.yml
├── docker-setup/
│   └── Dockerfile
├── mock-data/
│   ├── file1.txt
│   ├── file2.txt
│   └── file3.json
├── backups/
└── logs/
```

### Detailed Setup Instructions

#### 1. Project Initialization
A project directory and required subdirectories was created using the mkdir:
```bash
mkdir backup-project
cd backup-project
mkdir -p data backups logs docker-setup
```

#### 2. Mock Data Generation
Sample files(text1.txt, text2.txt, text3.txt) was created to demonstrate the backup system:
```bash
# The following information was put into the respective files using:
echo "This is test file 1" > data/text1.txt
echo "This is test file 2" > data/text2.txt
echo "This is test file 3" > data/text3.txt

#### 3. Docker Configuration
##### 3.1 Dockerfile Setup
Create a Dockerfile in the docker-setup directory:
```dockerfile
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    cron \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories
WORKDIR /app
RUN mkdir -p data backups logs

# Copy scripts and mock data
COPY backup-script.sh /app/
COPY recover-script.sh /app/
COPY mock-data/ /app/data/

# Make scripts executable
RUN chmod +x /app/*.sh

# Setup cron job
RUN (crontab -l 2>/dev/null; echo "0 0 * * * /app/backup-script.sh") | crontab -

# Start cron service and keep container running
CMD ["cron", "-f"]
```

##### 3.2 Docker Compose Configuration
Create docker-compose.yml in the root directory:
```yaml
version: '3.8'
services:
  backup-system:
    build:
      context: .
      dockerfile: docker-setup/Dockerfile
    volumes:
      - ./backups:/app/backups
      - ./logs:/app/logs
    restart: unless-stopped
```

#### 5. System Deployment
Build and start the Docker container:
```bash
# Build container
docker-compose build

# Start container in detached mode
docker-compose up -d
```

#### 6. Verification Steps
Verify the setup with these commands:
```bash
# Check container status
docker-compose ps

# Verify mock data files
docker-compose exec backup-system ls -l /app/data

# Confirm cron service
docker-compose exec backup-system ps aux | grep cron
```

#### 7. Testing Procedures
Test the backup and recovery functionality:
```bash
# Execute manual backup
docker-compose exec backup-system /app/backup-script.sh

# List backup files
docker-compose exec backup-system ls -l /app/backups

# Check backup logs
docker-compose exec backup-system cat /app/logs/backup.log

# Test recovery (interactive mode)
docker-compose exec -it backup-system /app/recover-script.sh
```

### System Management
Common management commands:
```bash
# Stop container
docker-compose down

# View container logs
docker-compose logs

# Access container shell
docker-compose exec backup-system bash

# View scheduled cron jobs
docker-compose exec backup-system crontab -l
```

### Notes
- The system performs daily backups at midnight (configurable via cron)
- Backup files are stored in the ./backups directory
- Logs are maintained in the ./logs directory
- All data persists across container restarts due to volume mapping

### Troubleshooting
If issues arise:
1. Check container logs for errors
2. Verify file permissions
3. Ensure all scripts are executable
4. Confirm cron service is running
5. Validate volume mount points

### Security Considerations
- Mock data files are stored within the container
- Backup files are persisted to host system
- Container runs with minimal required permissions
- System uses official Ubuntu base image

### Maintenance
Regular maintenance tasks:
- Monitor backup logs
- Check available disk space
- Review backup integrity
- Update scripts as needed
- Test recovery procedures periodically
