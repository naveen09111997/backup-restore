#!/bin/bash

# Define the source directories to be backup
source_directories=(
  "/opt/iplon/ddt"
  "/var/lib/mysql"
)

# Create a timestamp for the tar filename
timestamp=$(date +%Y-%m-%d)

#destination source directory
destination_source="/home/iplon/Backup/"

# Specify the destination directory
destination_directory="/home/iplon/Backup/$timestamp"
if [ ! -d "$directory" ]; then
  echo "directory $directory is not availables create directory"
  mkdir -p $destination_directory
fi

# Copy the source directories to the temporary directory while preserving the directory structure
for directory in "${source_directories[@]}"; do
  if [ -d "$directory" ]; then
    base_name=$(basename "$directory")
    cp -R "$directory" "$destination_directory/$base_name"
    echo "Copied $directory to $destination_directory/$base_name"
  else
    echo "Directory $directory does not exist"
  fi
done

cd $destination_source
# Create a tar backup of the temporary directory
tar -zcf "backup_${timestamp}.tar.gz" "$timestamp"

# Remove the temporary directory
rm -r "$destination_directory"

echo "Tar backup created at $destination_source/backup_${timestamp}.tar.gz"

# storing file to the remote system
cd $destination_source

rsync -a "backup_${timestamp}.tar.gz" root@192.168.1.19:~/Backup

find -mtime +7 -delete


