@echo off

set "targetFolder=E:\Converted_Video"
set "tmpString=%targetFolder%%~p1"
set "tmpString=%tmpString:~0,-1%"
call :GetLastPath "%tmpString%"
set "fileRootName=%targetFolder%\%folderRootName%\%~n1"

if not exist "%targetFolder%\%folderRootName%" mkdir "%targetFolder%\%folderRootName%" 

"C:\util\video\ffmpeg-20130406-git-7775992-win64-static\bin\ffmpeg.exe" -i %1 2> "%fileRootName%.txt"
FOR /F "tokens=1-4 delims= " %%A IN ('perl c:\util\video\parse_video_format.pl "%fileRootName%.txt"') DO (
  SET VIDEO_FORMAT=%%A
  SET DAR=%%B
  SET DEINTERLACE=%%C %%D
)
del "%fileRootName%.txt"

if EXIST "%fileRootName%.mkv" del "%fileRootName%.mkv"
REM "C:\util\video\ffmpeg-20121009-git-f3f35f7-win64-static\bin\ffmpeg.exe" -i %1 -c:v libx264 %DEINTERLACE% -s %VIDEO_FORMAT% -preset slow -crf 28 -b:a 128k "%fileRootName%.mkv"
"C:\util\video\ffmpeg-20130406-git-7775992-win64-static\bin\ffmpeg.exe" -i %1 -c:v libx264 %DEINTERLACE% -s %VIDEO_FORMAT% -preset slow -crf 28 -b:a 128k "%fileRootName%.mkv"
:EOF
exit /b %errorlevel%

:GetLastPath
set "folderRootName=%~nx1"
goto :EOF