@echo on

C:\util\MPlayer\mencoder.exe -oac copy -ovc copy -idx -o "%~dpn1-output.avi" %1 %2 %3

goto EOF

:EOF
pause