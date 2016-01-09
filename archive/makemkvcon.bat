@echo off

%~d1
cd %1
for /f "tokens=*" %%G in ('dir /ad /b') do (
   echo ___
   echo Found %%G
   "C:\Program Files (x86)\MakeMKV\makemkvcon64.exe" --minlength=0 mkv "file:%%G" 0 C:\Users\Public\Videos
   if not exist "C:\Users\Public\Videos\title00.mkv" (
      "C:\Program Files (x86)\MakeMKV\makemkvcon64.exe" --minlength=0 mkv "file:%%G\VIDEO_TS" 0 C:\Users\Public\Videos
   )
   if not exist "C:\Users\Public\Videos\title00.mkv" (
      echo ERROR
   ) else (
      rename "C:\Users\Public\Videos\title00.mkv" "%%~nG.mkv"
   )
)
pause
