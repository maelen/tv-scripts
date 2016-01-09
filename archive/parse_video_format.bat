@echo off
FOR /F "tokens=1-4 delims= " %%A IN ('perl c:\util\video\parse_video_format.pl %1') DO (
  SET VIDEO_FORMAT=%%A
  SET DAR=%%B
  SET DEINTERLACE=%%C %%D
)
echo OUTPUT
echo %VIDEO_FORMAT%
echo %DAR%
echo %DEINTERLACE%
pause

