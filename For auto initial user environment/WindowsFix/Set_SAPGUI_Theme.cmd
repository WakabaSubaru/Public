reg add HKEY_CURRENT_USER\SOFTWARE\SAP\General\Appearance /v SelectedTheme /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\SOFTWARE\SAP\SAPLogon\Options\ /v UseSAPLogonLanguageAsDefault /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\SOFTWARE\SAP\General\ /v Language /t REG_SZ /d EN /f