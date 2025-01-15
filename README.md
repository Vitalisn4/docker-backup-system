# GROUP MEMBERS
## Nafisatou
## Vitalis

# Exercise 5 : Backup and Recovery Automation

#### For the requirements have:
docker and docker-compose installed in your machine


Once the above requirement is met, go ahead and open the  repository using the link provided

Once on the repository is open, navigate to the 'code' tab and click there to copy either the http or ssh version

once the copied is done, head over to local machine and do:
```
git clone <url>
```
Replace the above url with the copied link

Once the clone is done, 'cd' into the directory where the project is found.

While in the directory where the project is found, make the backup and recover files executable using: 
```chmod +x backup-script.sh recover-script.sh```  
```
Then run this command on your terminal:
```
docker-compose build
```
The above command is to build and start the Docker container

Then now, run the container in a detached mode using:
```
docker-compose up -d
```
To check the status of the container, run the command:
```
docker-compose ps
```
To verify the mock data files, run the command:
```
docker-compose exec backup-system ls -l /app/data
```
To confirm if the cron service is working, run the command:
```
docker-compose exec backup-system ps aux | grep cron
```
Now, to execute manual backup, run the command:
```
docker-compose exec backup-system /app/backup-script.sh
```
To list the backup files, run the command:
```
docker-compose exec backup-system ls -l /app/backups
```
To check the logs, run the command:
```
docker-compose exec backup-system cat /app/logs/backup.log
```
To test recovery, use:
```
docker-compose exec -it backup-system /app/recover-script.sh
```
To view container logs, run:
```
docker-compose logs
```
To view scheduled cron jobs, run:
```
docker-compose exec backup-system crontab -l
```

