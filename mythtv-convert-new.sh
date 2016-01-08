#!/bin/sh

for file in /home/mythtv/storage/links/*.mpg
do
	if [ ! -e "$file".done ]; then		
		/usr/local/bin/convert_video.sh "$file" /home/mythtv/Converted_Video
		if [ $? -eq 0 ]; then
			touch "$file".done
		fi
	fi
done
for file in /home/mythtv/storage/links/*.mpg.done
do
	file=${file%.done}
	if [ ! -e "$file" ]; then
		rm "$file".done
	fi
done

mv /home/mythtv/Converted_Video/* /media/nasty/video/A\ Classer
