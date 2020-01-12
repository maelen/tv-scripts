#!/bin/bash +x

input_folder="$1"
#find "$input_folder" -type f -name '*.mp4' -print0 | while IFS= read -r -d '' input_file; do
for input_file in $input_folder/*.mp4; do
    echo $input_file
    file_base=$(basename "$input_file")
    output_file="$(dirname "$input_file")/${file_base%.*}.mkv"
    cmd="ffmpeg -y -i '"$input_file"' '"$output_file"'"
    echo $cmd
    eval $cmd
done

