@echo off

set "targetFolder=E:\Converted_Video"
set "tmpString=%targetFolder%%~p1"
set "tmpString=%tmpString:~0,-1%"
call :GetLastPath "%tmpString%"
set "fileRootName=%targetFolder%\%folderRootName%\%~n1"

if not exist "%targetFolder%\%folderRootName%" mkdir "%targetFolder%\%folderRootName%" 

if EXIST "%fileRootName%.mkv" del "%fileRootName%.mkv"
"C:\util\video\ffmpeg-20140405-git-ec8789a-win64-static\bin\ffmpeg.exe" -i %1 -map 0 -sn -c:v libx264 -vf "yadif=0:-1:0,scale=min(720\,iw):trunc(ow/a/2)*2" -preset slow -crf 21 -b:a 128k "%fileRootName%.mkv"
:EOF
exit /b %errorlevel%

:GetLastPath
set "folderRootName=%~nx1"
goto :EOF