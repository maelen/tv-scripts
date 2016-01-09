@echo off

set "targetFolder=C:\TV Recordings"
set "fileRootName=%targetFolder%\%~n1"

ffmpeg -i %1 2> "%fileRootName%.txt"
FOR /F "tokens=1-3 delims= " %%A IN ('perl c:\util\parse_video_format.pl "%fileRootName%.txt"') DO (
  SET VIDEO_FORMAT=%%A
  SET DAR=%%B
  SET DEINTERLACE=%%C
)

del "%fileRootName%.txt"
echo ffmpeg -i %1 -threads 6 -f avi -vsync -1 -async 10 -sameq %DEINTERLACE% "%fileRootName%-HD.avi"
goto EOF

:EOF
pause