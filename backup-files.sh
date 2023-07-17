#!/bin/bash

# Define the source directories to be archived
source_directories=(
  "/opt/iplon/ddt"
  "/var/lib/mysql"
)

# Specify the destination directory
destination_directory="/home/iplon/Backup"

# Create a timestamp for the tar filename
timestamp=$(date +%Y%m%d)

# Create a temporary directory to hold the individual directories
temp_directory=$(mktemp -d)

# Copy the source directories to the temporary directory while preserving the directory structure
for directory in "${source_directories[@]}"; do
  if [ -d "$directory" ]; then
    base_name=$(basename "$directory")
    cp -R "$directory" "$temp_directory/$base_name"
    echo "Copied $directory to $temp_directory/$base_name"
  else
    echo "Directory $directory does not exist"
  fi
done

# Create a tar archive of the temporary directory
tar -zcf "$destination_directory/backup_${timestamp}.tar.gz" -C "$temp_directory" .

# Remove the temporary directory
rm -r "$temp_directory"

echo "Tar archive created at $destination_directory/archive_${timestamp}.tar.gz"
