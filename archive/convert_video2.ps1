$fullFileName=$args[0]

$targetFolder="C:\Converted_Video"

$folderRootName=split-path "$fullFileName" -parent
$folderRootName=split-path "$folderRootName" -leaf
write-host "folderRootName:" $folderRootName

$fileRootName=[System.IO.Path]::GetFileNameWithoutExtension($fullFileName)
$fileRootName=($targetFolder+"\"+$folderRootName+"\"+$fileRootName)
write-host "fileRootName:" $fileRootName

if( ! (test-path -path ($targetFolder+"\"+$folderRootName)) )
{
   write-host "Path does not exist"
   new-item -type directory -path ($targetFolder+"\"+$folderRootName) | Out-Null
}

ffmpeg -i "$fullFileName" 2> ("$fileRootName"+".txt")
# FOR /F "tokens=1-3 delims= " %%A IN ('perl c:\util\parse_video_format.pl "%fileRootName%.txt"') DO (
#   SET VIDEO_FORMAT=%%A
#   SET DAR=%%B
#   SET DEINTERLACE=%%C
# )

# del "%fileRootName%.txt"
# if EXIST "%fileRootName%.avi" del "%fileRootName%.avi"
# ffmpeg -i %1 -threads 6 -f avi -r 29.97 -vcodec libxvid -vtag XVID -s %VIDEO_FORMAT% -aspect %DAR% -maxrate 1800k -b 1500k -qmin 3 -qmax 5 -bufsize 4096 -mbd 2 -bf 2 -flags +mv4 -ss 1 -vsync -1 -async 10 -trellis -aic -cmp 2 -subcmp 2 -g 300 -acodec libmp3lame -ar 48000 -ab 128k -ac 2 %DEINTERLACE% "%fileRootName%.avi"

Write-Host "Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
