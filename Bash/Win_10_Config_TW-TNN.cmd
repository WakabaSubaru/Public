SET SourceDir=%~dp0
IF %SourceDir:~-1%==\ (
	SET SourceDir=%SourceDir:~0,-1%
)


start gpupdate /force


reg import "%SourceDir%\WindowsFix\Reset_Outlook_Nav.reg"


powershell.exe -file "%SourceDir%\WindowsFix\Windows_NorUI.ps1"
powershell.exe -NoProfile -ExecutionPolicy Bypass -file "%SourceDir%\WindowsFix\Remove_UWP_APPs.ps1"
start cmd /c "%SourceDir%\WindowsFix\Set_SAPGUI_Theme.cmd"
start cmd /c "%SourceDir%\WindowsFix\Reinstall_MS_Teams\Reinstall_MS_Teams.cmd"