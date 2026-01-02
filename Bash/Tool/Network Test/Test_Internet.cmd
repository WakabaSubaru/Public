set "LogFolder=C:\%COMPUTERNAME%\"

echo ###Internet.### >> %LogFolder%Internet.txt
ping 8.8.8.8 >> %LogFolder%Internet.txt
ping 168.95.192.1 >> %LogFolder%Internet.txt
ping www.microsoft.com >> %LogFolder%Internet.txt

echo ###Microsoft Services.### >> %LogFolder%Internet.txt
ping passwordreset.microsoftonline.com >> %LogFolder%Internet.txt
ping portal.threatlocker.com >> %LogFolder%Internet.txt

echo ###Azure Platform.### >> %LogFolder%Internet.txt
ping JEA-SR001-DC-P >> %LogFolder%Internet.txt
ping NEU-SR001-DC-P >> %LogFolder%Internet.txt
ping SEA-SR001-DC-P >> %LogFolder%Internet.txt
ping WEU-SR001-DC-P >> %LogFolder%Internet.txt
ping WUS-SR001-DC-P >> %LogFolder%Internet.txt
ping WUS2-SR001-DC-P >> %LogFolder%Internet.txt
