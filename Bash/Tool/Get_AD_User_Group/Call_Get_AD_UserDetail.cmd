@echo off

SET SourceDir=%~dp0
IF %SourceDir:~-1%==\ (
	SET SourceDir=%SourceDir:~0,-1%
)


:loop
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\Get_AD_UserDetail.ps1"

echo.
echo Do you want to run the script again? (Y/N)
set /p choice=
if /i "%choice%"=="Y" goto loop