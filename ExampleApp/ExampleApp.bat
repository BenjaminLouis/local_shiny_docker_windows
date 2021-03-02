@echo off

setlocal enabledelayedexpansion

:: SETTING VARIABLE
:: ------------------------------------------------------
set dockerpath=C:"\Program Files\Docker\Docker\Docker Desktop.exe"
set /A port=80
set lg=fr
set name=ExampleApp
set img=exampleapp

:: INTRODUCTION
:: ------------
call tools/introduction

:: CHECKING IF DOCKER IS RUNNING AND LAUNCHING IT IF NOT
:: ------------------------------------------------------
call tools/docker_intro
docker ps >nul 2>nul
if not %errorlevel% == 0 (
    start %dockerpath%
    call tools/docker_waiting
    timeout /t 1 /nobreak >nul
)
:checkdocker
docker ps >nul 2>nul
if %errorlevel% == 0 (
    goto :dockerok
 ) else (
     timeout /t 1 /nobreak  >nul
     goto :checkdocker
)
:dockerok
call tools/docker_running

:: CHOOSING A FOLDER WHERE TO EXPORT RESULT
:: ----------------------------------------
:: fchooser.bat
:: launches a folder chooser and outputs choice to the console
:: https://stackoverflow.com/a/15885133/1683264
call tools/fchooser_intro
call tools/fchooser 
call tools/fchooser_choice

:: RUNNING DOCKER CONTAINER AND WAITING FOR localhost TO RESPOND
:: -------------------------------------------------------------
call tools/run_intro
docker run --rm -d -v %folder%:/export -p %port%:%port% %img% >nul
call tools/run_waiting
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
call tools/run_running
start http://127.0.0.1:%port%

endlocal

exit