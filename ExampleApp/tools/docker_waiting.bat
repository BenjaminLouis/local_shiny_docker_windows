@echo off

echo.

goto :%lg%

:fr
echo Docker n'est pas en fonctionnement
echo Lancement de Docker
echo.
echo En attente de docker...
goto :end

:end
echo.