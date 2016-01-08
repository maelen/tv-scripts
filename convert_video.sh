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

	/usr/bin/ffmpeg -i "$inputFile" -c:v libx264 -vf "yadif=0:-1:0,scale=min(720\,iw):trunc(ow/a/2)*2" -preset slow -crf 21 -b:a 128k -sn "$outputFile"
else
	echo "File does not exist"
fi
