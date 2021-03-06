@echo off

:: Parameter to go to the wanted message
set which=%~1

:: Which language
goto :%lg%


:: FRENCH
:: --------------------------
:fr

goto :%which%

:: docker image installation
:dockinstall
echo ========================================================
echo    INSTALLATION  DE %name%    
echo ========================================================
goto :end

:: image installation
:imginstall
echo INSTALLATION DE L'IMAGE DOCKER !
echo --------------------------------
goto :end

:: introduction
:introduction
echo ========================================================
echo    LANCEMENT DE %name%    
echo ========================================================
goto :end


:: docker introduction
:dockintro
echo VERIFICATION DE FONCTIONNEMENT DE DOCKER !
echo ------------------------------------------
goto :end

:: docker waiting
:dockwait
echo Docker n'est pas en fonctionnement. Lancement de Docker !
echo.
echo En attente...
goto :end

:: docker running
:dockrun
echo Docker est pret !
goto :end

:: folder chooser intro
:foldintro
echo CHOIX D'UN DOSSIER D'EXPORT !
echo -----------------------------
goto :end

:: folder choice
:foldchoice
echo Dossier choisi : %folder%
goto :end

:: launching application
:launchapp
echo LANCEMENT DE L'APPLICATION
echo --------------------------
echo.
echo Preparation de l'application...
goto :end

:: waiting for application
:waitapp
echo En attente de reponse de l'application...
goto :end



:: ENGLISH
:: --------------------------
:en
goto:end


:: End of messages
:end
echo.