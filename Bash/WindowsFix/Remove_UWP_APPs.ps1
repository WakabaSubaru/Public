#Reset all default apps.
#Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

#For current user.
get-AppxPackage Microsoft.getstarted | Remove-AppxPackage
get-appxpackage *oneconnect* | remove-appxpackage
get-appxpackage *officehub* | remove-appxpackage
get-AppxPackage Microsoft.getHelp | Remove-AppxPackage
get-appxpackage *windowsphone* | remove-appxpackage
get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
get-appxpackage *windowsphone* | remove-appxpackage
get-AppxPackage Microsoft.windowscommunicationsapps | Remove-AppxPackage
get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage
get-AppxPackage officehub | Remove-AppxPackage
get-appxpackage *skypeapp* | remove-appxpackage
get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage
get-appxpackage *feedback* | remove-appxpackage
get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage
#3rd apps
get-AppxPackage *konica* | Remove-AppxPackage
get-AppxPackage *winzip* | Remove-AppxPackage

reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve /d ""
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012078010000000 /f
taskkill /f /im explorer.exe
start explorer.exe


#For all user.
get-AppxPackage Microsoft.getstarted -AllUsers | Remove-AppxPackage
get-appxpackage *oneconnect* -AllUsers | remove-appxpackage
get-AppxPackage Microsoft.getHelp -AllUsers | Remove-AppxPackage
get-appxpackage *phone* -AllUsers | remove-appxpackage
get-AppxPackage Microsoft.YourPhone -AllUsers | Remove-AppxPackage
get-appxpackage *windowsphone* -AllUsers | remove-appxpackage
get-AppxPackage Microsoft.windowscommunicationsapps -AllUsers | Remove-AppxPackage
get-AppxPackage Microsoft.Office.OneNote -AllUsers | Remove-AppxPackage
get-AppxPackage officehub -AllUsers | Remove-AppxPackage
get-appxpackage *skypeapp* -AllUsers | Remove-AppxPackage
get-AppxPackage Microsoft.MixedReality.Portal -AllUsers | Remove-AppxPackage
get-appxpackage *officehub* -AllUsers | remove-appxpackage
get-appxpackage *feedback* -AllUsers | remove-appxpackage
get-appxpackage *Microsoft.549981C3F5F10* -AllUsers | Remove-AppxPackage
#3rd apps
get-AppxPackage *konica* -AllUsers | Remove-AppxPackage
get-AppxPackage *winzip* -AllUsers | Remove-AppxPackage