#!/bin/bash

script_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for file in /home/hts/recordings/*.{ts,mkv}
do
    if [ ! -e "$file".done ]; then
        $script_folder/convert_video.sh "$file" /home/hts/recordings_converted
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
