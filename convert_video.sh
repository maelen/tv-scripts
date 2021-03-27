#!/bin/sh

inputFile="$1"
outputFile="$2"

if [ -e "$inputFile" ]; then
    filebase=$(basename "$inputFile")
    if [ -d "$2" ]; then
        outputFile="$2"/${filebase%.*}.mkv
    elif [ "$outputFile" = "" ]; then
        outputFile=$(dirname "$inputFile")/${filebase%.*}_output.mkv
    fi

#echo inputFile $inputFile
#echo outputFile $outputFile

    /usr/bin/ffmpeg -y -i "$inputFile" -vf scale=1280:-1 -c:v libx264 -preset slow -crf 24 "$outputFile"
else
    echo "File does not exist"
fi
