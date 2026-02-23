#!/bin/bash



source=$1
dest=$2
type=$3

# check arguments
if [ $# -ne 3 ]
then
    echo "Usage: ./q4_backup.sh <source_dir> <destination_dir> <copy|tar>"
    exit 1
fi

# validate source
if [ ! -d "$source" ]
then
    echo "Source directory not found."
    exit 1
fi

# create destination if not exists
if [ ! -d "$dest" ]
then
    mkdir -p "$dest"
fi

timestamp=$(date +%Y%m%d_%H%M%S)
start=$(date +%s)

filename="backup_$timestamp"

echo "Starting backup..."
echo "Source: $source"
echo "Destination: $dest"

if [ "$type" = "copy" ]
then
    cp -r "$source" "$dest/$filename"

elif [ "$type" = "tar" ]
then
    tar -czf "$dest/$filename.tar.gz" -C "$(dirname "$source")" "$(basename "$source")"

else
    echo "Invalid backup type. Use 'copy' or 'tar'."
    exit 1
fi

end=$(date +%s)
time_taken=$((end - start))

# verify
if [ "$type" = "copy" ] && [ -d "$dest/$filename" ]
then
    size=$(du -sh "$dest/$filename" | awk '{print $1}')
    echo "Backup completed."
    echo "File: $filename"
    echo "Size: $size"
    echo "Time: $time_taken seconds"

elif [ "$type" = "tar" ] && [ -f "$dest/$filename.tar.gz" ]
then
    size=$(du -sh "$dest/$filename.tar.gz" | awk '{print $1}')
    echo "Backup completed."
    echo "File: $filename.tar.gz"
    echo "Size: $size"
    echo "Time: $time_taken seconds"

else
    echo "Backup failed."
fi
