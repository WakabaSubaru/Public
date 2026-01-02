REM License: GNU General Public License v2.0
REM Author: Miguel 
REM Website: www.techlogist.net
REM Post: https://techlogist.net/scripts-terminal/batch/how-to-set-7zip-as-the-default-application-to-open-certain-compressed-files-type-via-script/
REM Description: This script makes 7Zip the default app for the following extensions:
REM .7z, .zip, .rar, .gz, .tgz, .tar
REM OS/Language/Region: Windows/EN-US
REM Notes:
REM 1) Does not require administrator rights to make changes for current logged in user but displays "Access Denied"
REM 2) If ran as administrator will change for all users.

:_start
REM Start of script
@echo off
cls
title 7zFM Default v.1
color f0
mode con:cols=70 lines=15
goto _set_folders

:_set_folders
REM Set the folders to be verified
cls
set _7zFMFolder=C:\Program Files\7-Zip\
goto _7zFM

:_7zFM
REM Check if 7zFM is available
IF EXIST "%_7zFMFolder%\7zFM.exe" (goto _change_registry) else (goto _7zip_unavailable)
goto _7zFM

:_7zip_unavailable
REM This routine will advise the user to install 7-Zip because its missing and log it.

REM The error screen for 7-Zip is missing
color 47
cls
echo ----------------------------------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo                   7-Zip is unavailable. Please install
echo.
echo.
echo.
echo.
echo.
echo ----------------------------------  ----------------------------------
pause
color f0
goto EOF

:_change_registry
REM The error screen for 7-Zip is missing
color f0
cls
echo ----------------------------------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo                   Changing registry....
echo.
echo.
echo.
echo.
echo.
echo ----------------------------------  ----------------------------------

REM Update registry for different types of compressed files:
REM .7z, .zip, .rar, .gz, .tgz, .tar

REM Create the entry 7-Zip.zip in the registry

REG ADD HKEY_CLASSES_ROOT\7-Zip.zip /d "zip Archive" /f > nul
REG ADD HKEY_CLASSES_ROOT\7-Zip.zip\DefaultIcon /d "C:\Program Files\7-Zip\7z.dll,4" /f > nul
REG ADD HKEY_CLASSES_ROOT\7-Zip.zip\shell /f > nul
REG ADD HKEY_CLASSES_ROOT\7-Zip.zip\shell\open /f > nul
REG ADD HKEY_CLASSES_ROOT\7-Zip.zip\shell\open\command /d "\"C:\Program Files\7-Zip\7zFM.exe\" \"%%1\"" /f > nul

REG ADD HKEY_CURRENT_USER\Software\Classes\7-Zip.zip /d "zip Archive" /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\7-Zip.zip\DefaultIcon /d "C:\Program Files\7-Zip\7z.dll,4" /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\7-Zip.zip\shell /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\7-Zip.zip\shell\open /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\7-Zip.zip\shell\open\command /d "\"C:\Program Files\7-Zip\7zFM.exe\" \"%%1\"" /f > nul

REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\7-Zip.zip /d "zip Archive" /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\7-Zip.zip\DefaultIcon /d "C:\Program Files\7-Zip\7z.dll,4" /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\7-Zip.zip\shell /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\7-Zip.zip\shell\open /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\7-Zip.zip\shell\open\command /d "\"C:\Program Files\7-Zip\7zFM.exe\" \"%%1\"" /f > nul

REM The change in HKEY_CLASSES_ROOT is implemented to all users
REM the change in HKEY_CURRENT_USER\Software\Classes\ is the the curretly logged in user

REM Update for .7z
REG ADD HKEY_CLASSES_ROOT\.7z /d 7-Zip.zip /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\.7z  /d 7-Zip.zip /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.7z  /d 7-Zip.zip /f > nul
REM Update for .zip
REG ADD HKEY_CLASSES_ROOT\.zip /d 7-Zip.zip /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\.zip /d 7-Zip.zip /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.zip /d 7-Zip.zip /f > nul
REM Update for .rar
REG ADD HKEY_CLASSES_ROOT\.rar /d 7-Zip.zip /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\.rar /d 7-Zip.zip /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.rar /d 7-Zip.zip /f > nul
REM Update for .gz
REG ADD HKEY_CLASSES_ROOT\.gz /d 7-Zip.zip /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\.gz /d 7-Zip.zip /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.gz /d 7-Zip.zip /f > nul
REM Update for .tgz
REG ADD HKEY_CLASSES_ROOT\.tgz /d 7-Zip.zip /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\.tgz /d 7-Zip.zip /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.tgz /d 7-Zip.zip /f > nul
REM Update for .tar
REG ADD HKEY_CLASSES_ROOT\.tar /d 7-Zip.zip /f > nul
REG ADD HKEY_CURRENT_USER\Software\Classes\.tar /d 7-Zip.zip /f > nul
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.tar /d 7-Zip.zip /f > nul


:_Done
REM The error screen for 7-Zip is missing
color f0
cls
echo ----------------------------------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo                   All Done!
echo.
echo.
echo.
echo.
echo.
echo ----------------------------------------------------------------------
pause
goto EOF

:EOF
REM End of the file
cls
exit