#!/bin/bash

# Check if a directory path is provided as an argument
if [ $# -ne 3 ]; then
    echo "Usage: $0 <home team image> <away team image> <directory_path>"
    exit 1
fi

home_team="$1"
away_team="$2"
directory_path="$3"

# Create vs image
montage $home_team $away_team -tile 2x1 -background none -geometry +0+0 /tmp/game.png 

# Check if the provided path is a directory
if [ ! -d "$directory_path" ]; then
    echo "Error: $directory_path is not a directory."
    exit 1
fi

# List the names of files in the directory
for file in "$directory_path"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        filename_without_extension="${filename%.*}"
        echo convert \"$file\" /tmp/game.png -gravity southeast -geometry +10+10 -composite \"$directory_path/$filename_without_extension.bug.jpeg\"
    fi
done

