@echo on

set "targetFolder=C:\TV Recordings\_AVI"
set "fileRootName=%targetFolder%\%~n1"


if EXIST %1.xcl java -jar "C:\util\ProjectX\ProjectX.jar" -ini "C:\util\ProjectX\X.ini" -cut %1.xcl -out "%targetFolder%" %1
if NOT EXIST %1.xcl java -jar "C:\util\ProjectX\ProjectX.jar" -ini "C:\util\ProjectX\X.ini" -demux -out "%targetFolder%" %1

if EXIST "%fileRootName%.ac3" (set audio="%fileRootName%.ac3")
if EXIST "%fileRootName%.mp2" (set audio="%fileRootName%.mp2")
del "%fileRootName%_log.txt"

ffmpeg -i "%fileRootName%.m2v" 2> "%fileRootName%.txt"
FOR /F "tokens=1-3 delims= " %%A IN ('perl c:\util\parse_video_format.pl "%fileRootName%.txt"') DO (
  SET VIDEO_FORMAT=%%A
  SET DAR=%%B
  SET DEINTERLACE=%%C
)

del "%fileRootName%.txt"
ffmpeg -i "%fileRootName%.m2v" -i %audio% -threads 6 -f avi -r 29.97 -vcodec libxvid -vtag XVID -s %VIDEO_FORMAT% -aspect %DAR% -maxrate 1800k -b 1500k -qmin 3 -qmax 5 -bufsize 4096 -mbd 2 -bf 2 -flags +mv4 -trellis -aic -cmp 2 -subcmp 2 -g 300 -acodec libmp3lame -ar 48000 -ab 128k -ac 2 %DEINTERLACE% "%fileRootName%.avi"

if EXIST "%fileRootName%.m2v" del "%targetFolder%\*.m2v"
if EXIST %audio% del %audio%

if EXIST %1.xcl move %1.xcl %1.xcl.done
goto EOF

:EOF