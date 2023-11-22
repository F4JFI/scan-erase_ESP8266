@echo off
setlocal enabledelayedexpansion

echo Recherche des ports COM disponibles...

REM Liste les ports COM disponibles
set "PortsDisponibles="
for /l %%x in (1, 1, 256) do (
    mode COM%%x: >nul 2>nul
    if !errorlevel! equ 0 (
        set "PortsDisponibles=!PortsDisponibles! COM%%x"
    )
)

REM Affiche les ports disponibles
echo Ports COM disponibles : %PortsDisponibles%

REM Demande à l'utilisateur de choisir un port COM
set /p "PortChoisi=Entrez le numéro du port COM à utiliser : "

REM Vérifie si le port choisi est dans la liste des ports disponibles
echo %PortsDisponibles% | find /i "COM%PortChoisi%" >nul
if not errorlevel 1 (
    echo Port COM%PortChoisi% choisi.
    set "Commande=esptool.exe --port COM%PortChoisi% erase_flash"
    echo !Commande!
    !Commande!
) else (
    echo Le port COM%PortChoisi% n'est pas disponible.
)

pause
