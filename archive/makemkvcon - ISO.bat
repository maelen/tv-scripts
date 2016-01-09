@echo off

for %%G IN (%*) do (
   echo ___
   echo Found %%G
   "C:\Program Files (x86)\MakeMKV\makemkvcon64.exe" --minlength=0 mkv iso:%%G 0 C:\Users\Public\Videos
   REM if not exist "C:\Users\Public\Videos\title00.mkv" (
   REM "C:\Program Files (x86)\MakeMKV\makemkvcon64.exe" mkv "iso:%%G\VIDEO_TS" 0 C:\Users\Public\Videos
   REM )
   if not exist "C:\Users\Public\Videos\title00.mkv" (
   echo ERROR
   ) else (
   rename "C:\Users\Public\Videos\title00.mkv" "%%~nG.mkv"
   )
)
pause
