@echo off
SET SourceDir=%~dp0
IF %SourceDir:~-1%==\ (
    SET SourceDir=%SourceDir:~0,-1%
)


REM Terminate SAP Business Client process.
taskkill /im SAP.BusinessClient.Desktop.exe /f /t


start cmd /c "%SourceDir%\Remove_Browser_Cache.cmd"


REM Clear cache for current user.
rmdir "%appdata%\SAP SE" /s /q
rmdir "%appdata%\Microsoft\Crypto" /s /q


REM Clear cache for all users.
for /d %%u in (C:\Users\*) do (
    if exist "%%u\AppData\Roaming\SAP SE" (
        echo Clearing SAP SE cache for %%u
        rmdir "%%u\AppData\Roaming\SAP SE" /s /q
    )
    if exist "%%u\AppData\Roaming\Microsoft\Crypto" (
        echo Clearing Microsoft Crypto cache for %%u
        rmdir "%%u\AppData\Roaming\Microsoft\Crypto" /s /q
    )
)


echo Cache clearing completed for all users.
pause
exit