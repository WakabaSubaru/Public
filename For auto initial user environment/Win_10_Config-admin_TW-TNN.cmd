SET SourceDir=%~dp0
IF %SourceDir:~-1%==\ (
    SET SourceDir=%SourceDir:~0,-1%
)


sysdm.cpl


start cmd /c "%SourceDir%\WindowsFix\Call_Windows_Language_Add_Chinese_IME.cmd"
start cmd /c "%SourceDir%\WindowsFix\Set_7-Zip_Default.cmd"
start cmd /c "%SourceDir%\Drivers\PowerPlan_Default.cmd"
powershell.exe -NoProfile -ExecutionPolicy Bypass -file "%SourceDir%\WindowsFix\Remove_UWP_APPs.ps1"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%SourceDir%\Tool\Del_UserProfiles.ps1"

choice /C YN /n /m "Uninstall Dell-optimizer?"
IF %ERRORLEVEL% EQU 1 goto UninstallOptimizer
IF %ERRORLEVEL% EQU 2 goto Continue

:UninstallOptimizer
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -like '*Dell Optimizer*'} | ForEach-Object {$_.Uninstall()}"
goto Continue

:Continue
choice /C YN /n /m "Install Dell-CommandUpdate?"
IF %ERRORLEVEL% EQU 1 goto Install_CommandUpdate
IF %ERRORLEVEL% EQU 2 goto End

:Install_CommandUpdate
"%SourceDir%\Drivers\Dell-Command-Update_5.5.0.exe" /s
start "" "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /scan /applyupdates -silent -autoSuspendBitLocker=enabled
goto End

:End
start "" "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /scan /applyupdates -silent -autoSuspendBitLocker=enabled
explorer
exit