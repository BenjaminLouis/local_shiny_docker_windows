@echo off

setlocal enabledelayedexpansion

:: INTRODUCTION
:: ------------
call tools/messages introduction

:: CHECKING IF DOCKER IS RUNNING AND LAUNCHING IT IF NOT
:: ------------------------------------------------------
call tools/messages dockintro
docker ps >nul 2>nul
if not %errorlevel% == 0 (
    start %dockerpath%
    call tools/messages dockwait
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
call tools/messages dockrun


endlocal

exit