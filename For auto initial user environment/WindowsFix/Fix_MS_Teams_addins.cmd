@echo off


taskkill /IM Teams.exe /F
taskkill /IM ms-teams.exe /F
taskkill /IM Outlook.exe /F


wmic product where "name like 'Microsoft Teams%'" call uninstall
wmic product where "name like 'Teams Machine-Wide Installer%'" call uninstall


rmdir "%appdata%\Microsoft\teams\" /s /q
rmdir "%localappdata%\Microsoft\Teams\" /s /q
rmdir "%appdata%\Microsoft\TeamsMeetingAddin\" /s /q
rmdir "%appdata%\Microsoft\TeamsMeetingAdd-in\" /s /q
rmdir "%appdata%\Microsoft\TeamsPresenceAddin\" /s /q


explorer "%localappdata%\Microsoft\WindowsApps\ms-teams.exe"
exporer "C:\Program Files\WindowsApps\MSTeams_24243.1309.3132.617_x64__8wekyb3d8bbwe\ms-teams.exe"