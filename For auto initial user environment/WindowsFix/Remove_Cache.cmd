@ECHO off

runDll32.exe InetCpl.cpl,ClearMyTracksByProcess 435
taskkill /f /IM msedge.exe
taskkill /f /IM msedgewebview2.exe
rmdir "%localappdata%\Microsoft\Edge\User Data\Default\Cache\Cache_Data" "%localappdata%" /s /q