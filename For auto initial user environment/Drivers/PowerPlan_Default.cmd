@echo off
setlocal EnableExtensions

:: ===== Admin check =====
net session >nul 2>&1
if %errorlevel% neq 0 (
	echo [ERROR] This script must be run as Administrator.
	exit /b 1
	)

:: ===== Optional: force a known plan (recommended for enterprise consistency) =====
:: If you want to always base settings on Balanced plan, keep this line.
powercfg /setactive SCHEME_BALANCED

:: ===== Power mode (Windows 11 UI: Best performance / Balanced / Best power efficiency) =====
:: Options: PERFORMANCE / BALANCED / SAVER
set "MODE_AC=PERFORMANCE"
set "MODE_DC=BALANCED"

call :SetEPP AC "%MODE_AC%"
call :SetEPP DC "%MODE_DC%"

:: ===== Enable hibernate =====
powercfg /hibernate on

:: ===== Disable Windows Fast Startup (fastboot) =====
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" ^
  /v HiberbootEnabled /t REG_DWORD /d 0 /f

:: ===== Shutdown flyout options (may be version/OEM dependent) =====
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" ^
  /v ShowHibernateOption /t REG_DWORD /d 1 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" ^
  /v ShowSleepOption /t REG_DWORD /d 0 /f

:: ===== Timeouts =====
powercfg /change monitor-timeout-ac 15
powercfg /change monitor-timeout-dc 5

powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0

powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 5

:: ===== Button / lid actions =====
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 2
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 2

powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 2
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 2

powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 2

:: ===== Apply active scheme =====
powercfg /setactive SCHEME_CURRENT

:: ===== (Optional) verify EPP =====
:: powercfg /q SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 36687f9e-e3a5-4dbf-b1dc-15eb381c6863

echo [OK] Power settings applied.
exit /b 0

:: -------------------------
:: SetEPP: map power mode -> EPP value and apply to current plan
:: AC/DC + (PERFORMANCE/BALANCED/SAVER)
:SetEPP
set "PWR=%~1"
set "MODE=%~2"
set "EPP="

if /I "%MODE%"=="PERFORMANCE" set "EPP=0"
if /I "%MODE%"=="BALANCED"    set "EPP=50"
if /I "%MODE%"=="SAVER"       set "EPP=80"

if not defined EPP (
	echo [ERROR] Invalid %PWR% mode: %MODE%  (use PERFORMANCE/BALANCED/SAVER)
	exit /b 2
)

set "SUB_PROCESSOR=54533251-82be-4824-96c1-47b60b740d00"
set "EPP_GUID=36687f9e-e3a5-4dbf-b1dc-15eb381c6863"

if /I "%PWR%"=="AC" (
	powercfg /setacvalueindex SCHEME_CURRENT %SUB_PROCESSOR% %EPP_GUID% %EPP%
	) else (
	powercfg /setdcvalueindex SCHEME_CURRENT %SUB_PROCESSOR% %EPP_GUID% %EPP%
	)

exit /b 0
