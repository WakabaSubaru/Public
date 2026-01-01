Reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /f
Reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /f
Reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet001\WindowsUpdate" /f
Reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\GPCache\CacheSet002\WindowsUpdate" /f
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t Reg_DWORD /d 0 /f
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseUpdateClassPolicySource" /t Reg_DWORD /d 1 /f
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t Reg_DWORD /d 0 /f

timeout 3 /nobreak
net stop wuauserv
timeout 3 /nobreak
net start wuauserv
timeout 3 /nobreak

Dism /online /Add-Capability /CapabilityName:Language.Basic~~~zh-TW~0.0.1.0
Dism /online /Add-Capability /CapabilityName:Language.Handwriting~~~zh-TW~0.0.1.0
Dism /online /Add-Capability /CapabilityName:Language.OCR~~~zh-TW~0.0.1.0
Dism /online /Add-Capability /CapabilityName:Language.Speech~~~zh-TW~0.0.1.0
Dism /online /Add-Capability /CapabilityName:Language.TextToSpeech~~~zh-TW~0.0.1.0
Dism /online /Add-Capability /CapabilityName:Language.Fonts.Hant~~~und-HANT~0.0.1.0


Install-Language zh-TW
Set-SystemPreferredUILanguage en-US