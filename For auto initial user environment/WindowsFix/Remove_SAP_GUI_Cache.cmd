SET SourceDir=%~dp0
IF %SourceDir:~-1%==\ (
	SET SourceDir=%SourceDir:~0,-1%
)


taskkill /im SapGuiServer.exe /f /t
reg delete "HKEY_CURRENT_USER\SOFTWARE\SAP" /f
rmdir "%AppData%\SAP" /s /q

start cmd /c "%SourceDir%\\Set_SAPGUI_Theme.cmd"