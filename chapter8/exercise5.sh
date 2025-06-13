#!/bin/bash

read -p "Enter the filename: " FILENAME

echo "Properties for $FILENAME:"

if [ -f "$FILENAME" ]; then
    echo "Size is $(ls -lh "$FILENAME" | awk '{ print $5 }')"
    echo "Type is $(file "$FILENAME" | cut -d":" -f2-)"
    echo "Inode number is $(ls -i "$FILENAME" | awk '{ print $1 }')"
    echo "$(df -h "$FILENAME" | awk 'NR==2 { print "On", $1 ", which is mounted as the", $6, "partition." }')"
else
    echo "File does not exist."
fi
