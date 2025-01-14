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
COPY data/ /app/data/

# Make scripts executable
RUN chmod +x /app/*.sh

# Setup cron job
RUN (crontab -l 2>/dev/null; echo "0 0 * * * /app/backup-script.sh") | crontab -

# Start cron service and keep container running
CMD ["cron", "-f"]
