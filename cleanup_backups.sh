#!/bin/bash

# Define the directory where your backups are stored
backup_dir="/home/tr00ls/archives"

# Define the number of days after which backups should be considered old
days_to_keep=7

# Use the find command to locate files older than the specified threshold
find "$backup_dir" -type f -mtime +$days_to_keep -exec rm {} \;




crontab -e

0 2 * * * /path/to/cleanup_backups.sh
