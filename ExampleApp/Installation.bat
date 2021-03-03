@echo off

setlocal enabledelayedexpansion

:: SETTING VARIABLE
:: ------------------------------------------------------
set "dockerpath="
set lg=fr
set name=ExampleApp
set img=exampleapp

:: INTRODUCTION
:: ------------
call tools/messages dockinstall

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

:: INSTALLING APPLICATION DOCKER IMAGE
:: -----------------------------------
call tools/messages imginstall
docker build -t %img% ./app


endlocal

exit