Restart-Service -Name CcmExec

dism /online /cleanup-image /scanhealth
dism /online /cleanup-image /checkhealth
dism /online /cleanup-image /restorehealth
sfc /scannow