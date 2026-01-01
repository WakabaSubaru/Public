SET SourceDir=%~dp0
IF %SourceDir:~-1%==\ (
	SET SourceDir=%SourceDir:~0,-1%
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SourceDir%\Windows_Language_Add_Chinese_IME.ps1"