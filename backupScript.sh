#!/bin/bash

# Source directory to be backed up
SOURCE_DIR="/path/to/source"

# Destination directory for backups
BACKUP_DIR="/path/to/backup"

# Date format for the backup folder name
DATE_FORMAT="%Y-%m-%d"

# Create a backup folder with today's date
TODAY=$(date +"$DATE_FORMAT")
BACKUP_FOLDER="$BACKUP_DIR/$TODAY"
mkdir -p "$BACKUP_FOLDER"

# Previous backup folder (link-dest target)
PREVIOUS=$(date -d "yesterday" +"$DATE_FORMAT")
PREVIOUS_FOLDER="$BACKUP_DIR/$PREVIOUS"

# Perform the backup using rsync with link-dest
rsync -a --link-dest="$PREVIOUS_FOLDER" "$SOURCE_DIR" "$BACKUP_FOLDER"

# Optional: Delete backups older than X days
# X=7 for keeping backups of the last 7 days
find "$BACKUP_DIR" -type d -mtime +7 -exec rm -rf {} \;
