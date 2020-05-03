#!/bin/bash

for file in /home/hts/recordings/*.{ts,mkv}
do
	if [ ! -e "$file".done ]; then
		/usr/local/bin/convert_video.sh "$file" /home/hts/recordings_converted
		if [ $? -eq 0 ]; then
			touch "$file".done
		fi
	fi
done
for file in /home/hts/recordings/*.done
do
	file=${file%.done}
	if [ ! -e "$file" ]; then
		rm "$file".done
	fi
done

mv /home/hts/recordings_converted/* /media/nasgul/usbdisk/Recordings/
