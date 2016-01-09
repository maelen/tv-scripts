@echo off

%~d1
cd %1
for %%G in (*.avi) do ( 
   echo Found %%G
   perl c:\util\boxee_add_nfo.pl "%%G"
)
for %%G in (*.iso) do ( 
   echo Found %%G
   perl c:\util\boxee_add_nfo.pl "%%G"
)
for %%G in (*.mkv) do ( 
   echo Found %%G
   perl c:\util\boxee_add_nfo.pl "%%G"
)

for %%G in (*.flv) do ( 
   echo Found %%G
   perl c:\util\boxee_add_nfo.pl "%%G"
)
pause