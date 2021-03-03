@echo off

setlocal enabledelayedexpansion

:: SETTING VARIABLE
:: ------------------------------------------------------
::set dockerpath=C:"\Program Files\Docker\Docker\Docker Desktop.exe"
set "dockerpath="
set /A port=80
set lg=fr
set name=ExampleApp
set img=exampleapp

:: INTRODUCTION
:: ------------
call tools/messages introduction

:: CHECKING IF DOCKER IS RUNNING AND LAUNCHING IT IF NOT
:: ------------------------------------------------------
call tools/messages dockintro
docker ps >nul 2>nul
if not %errorlevel% == 0 (
    goto :launchdocker 
) else (
    goto :dockerok
)
:: startingdocker
:launchdocker
call tools/finddocker
start %dockerpath%
call tools/messages dockwait
timeout /t 1 /nobreak >nul
:: checking if docker is running
:checkdocker
docker ps >nul 2>nul
if %errorlevel% == 0 (
    goto :dockerok
 ) else (
     timeout /t 1 /nobreak  >nul
     goto :checkdocker
)
:: docker is running
:dockerok
call tools/messages dockrun

:: CHOOSING A FOLDER WHERE TO EXPORT RESULT
:: ----------------------------------------
:: fchooser.bat
:: launches a folder chooser and outputs choice to the console
:: https://stackoverflow.com/a/15885133/1683264
call tools/messages foldintro
call tools/fchooser 
call tools/messages foldchoice

:: RUNNING DOCKER CONTAINER AND WAITING FOR localhost TO RESPOND
:: -------------------------------------------------------------
call tools/messages launchapp
docker run --rm -d -v %folder%:/export -p %port%:%port% %img% >nul
call tools/messages waitapp
:pinglocal
curl -s 127.0.0.1:%port% >nul
if %errorlevel% == 0 (
    goto :localok
) else (
    goto :pinglocal
)
:localok

:: STARTING localhost
:: ------------------
start http://127.0.0.1:%port%

endlocal

exit