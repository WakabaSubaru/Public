SET SourceDir=%~dp0
IF %SourceDir:~-1%==\ (
	SET SourceDir=%SourceDir:~0,-1%
)


taskkill /IM Teams.exe /F
taskkill /IM ms-teams.exe /F
taskkill /IM Outlook.exe /F


wmic product where "name like 'Microsoft Teams%'" call uninstall
wmic product where "name like 'Teams Machine-Wide Installer%'" call uninstall
powershell.exe -command "get-AppxPackage MSTeams% | Remove-AppxPackage"


for %%t in (
	"%appdata%\Microsoft\teams\"
	"%localappdata%\Microsoft\Teams\"
	"%appdata%\Microsoft\TeamsMeetingAddin\"
	"%appdata%\Microsoft\TeamsMeetingAdd-in\"
	"%appdata%\Microsoft\TeamsPresenceAddin\"
	"%appdata%\Packages\MSTeams_8wekyb3d8bbwe\"
	) do (
	echo Removing %%t
	rmdir /s /q %%t
	)


"%sourcedir%\MSTeamsSetup.exe"

taskkill /IM Outlook.exe
timeout 30 /nobreak
start Outlook
exit



