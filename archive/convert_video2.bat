@echo off

set "targetFolder=E:\Converted_Video"
set "tmpString=%targetFolder%%~p1"
set "tmpString=%tmpString:~0,-1%"
call :GetLastPath "%tmpString%"
set "fileRootName=%targetFolder%\%folderRootName%\%~n1"

if not exist "%targetFolder%\%folderRootName%" mkdir "%targetFolder%\%folderRootName%" 

"%~dp0\ffmpeg.exe" -i %1 2> "%fileRootName%.txt"
FOR /F "tokens=1-3 delims= " %%A IN ('perl c:\util\parse_video_format.pl "%fileRootName%.txt"') DO (
  SET VIDEO_FORMAT=%%A
  SET DAR=%%B
  SET DEINTERLACE=%%C
)

del "%fileRootName%.txt"
if EXIST "%fileRootName%.avi" del "%fileRootName%.avi"
"%~dp0\ffmpeg.exe" -i %1 -threads 6 -f avi -r 29.97 -vcodec libxvid -vtag XVID -s %VIDEO_FORMAT% -aspect %DAR% -maxrate 1800k -b 1500k -qmin 3 -qmax 5 -bufsize 4096 -mbd 2 -bf 2 -flags +mv4 -ss 1 -vsync -1 -async 10 -trellis -aic -cmp 2 -subcmp 2 -g 300 -acodec libmp3lame -ar 48000 -ab 128k -ac 2 %DEINTERLACE% "%fileRootName%.avi"

:EOF
exit /b %errorlevel%

:GetLastPath
set "folderRootName=%~nx1"
goto :EOF