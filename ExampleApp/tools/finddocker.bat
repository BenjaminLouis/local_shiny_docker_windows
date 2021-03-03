@echo off

set "fo="
set /A compt=0

for /f "tokens=* delims= " %%x in ('dir c:\ /w/o/p/b/ad ^| findstr Program.*') do set "fo=%%x" && call :save
set /A compt2=0
goto :testpath

:save
set /A compt+=1
set list[%compt%]=%fo%
goto :end

:testpath
set /A compt2+=1
set dockerpath=C:"\!list[%compt2%]!\Docker\Docker\Docker Desktop.exe"
::echo %dockerpath%
if exist %dockerpath% ( 
    goto :end 
) else ( 
    goto :testpath 
)

:end
