set "SourceDir=%~dp0"
set "LogFolder=C:\%COMPUTERNAME%\"


if exist %LogFolder% (
	rmdir /s /q %LogFolder%
	)
if not exist %LogFolder% (
	mkdir %LogFolder%
	)

ipconfig /flushdns > %LogFolder%ipconfig.txt
timeout /t 5 /nobreak
ipconfig /renew >> %LogFolder%ipconfig.txt
timeout /t 5 /nobreak
ipconfig /all >> %LogFolder%ipconfig.txt
timeout /t 5 /nobreak
start cmd /c "%SourceDir%Test_Intranet.cmd"
start /wait cmd /c "%SourceDir%Test_Internet.cmd"

pause

rmdir /s /q "%SourceDir%%COMPUTERNAME%"
robocopy %LogFolder% "%SourceDir%Result\%COMPUTERNAME%" /e /z
rmdir /s /q "%LogFolder%"

pause