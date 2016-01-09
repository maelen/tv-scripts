@echo off

set "targetFolder=C:\Users\marijo\Videos"

IF EXIST "%~1\" (
	%~d1%
	cd "%~pn1%"
	for /R %%F in (*.mkv) do (
		echo Converting %%F
		if EXIST "%targetFolder%\%%~nF.mkv" del "%targetFolder%\%%~nF.mkv"
		"C:\util\video\ffmpeg-20130406-git-7775992-win64-static\bin\ffmpeg.exe" -i "%%F" -map 0:v -map 0:a -c:v libx264 -vf "yadif=0:-1:0,scale=min(720\,iw):trunc(ow/a/2)*2" -preset slow -crf 18 -c:a ac3 -sn  "%targetFolder%\%%~nF.mkv"
	)
) else (
	for %%F IN ("%*") do (
		echo Converting %%F
		if EXIST "%targetFolder%\%%~nF.mkv" del "%targetFolder%\%%~nF.mkv"
		"C:\util\video\ffmpeg-20130406-git-7775992-win64-static\bin\ffmpeg.exe" -i "%%F" -map 0:v -map 0:a -c:v libx264 -vf "yadif=0:-1:0,scale=min(720\,iw):trunc(ow/a/2)*2" -preset slow -crf 18 -c:a ac3 -sn  "%targetFolder%\%%~nF.mkv"
	)
)