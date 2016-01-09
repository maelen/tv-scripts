@echo on

ffmpeg -i %1 2> %1.txt
type %1.txt
pause
FOR /F "tokens=1-3 delims= " %%A IN ('perl c:\util\parse_video_format.pl %1.txt') DO (
  SET VIDEO_FORMAT=%%A
  SET DAR=%%B
  SET DEINTERLACE=%%C
)

echo %VIDEO_FORMAT%
echo %DAR%
echo %DEINTERLACE%
pause