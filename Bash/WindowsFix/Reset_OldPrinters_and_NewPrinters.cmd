@echo off


echo:
echo 1. Program start.

echo 2. Please save all your documents and close, then press any button to go to the next step.
timeout /t 300

echo 3. Kill programs: Excel, Acrobat.
taskkill /im excel.exe /im Acrobat.exe /f
reg delete "HKEY_CURRENT_USER\Printers" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\KONICA MINOLTA" /f

echo 4. remove old printer.
for %%p in (
	"\\asmtwmfd01\C227_Mono"
	"\\asmtwmfd01\C227_Color"
	"\\asmtwmfd01\Houli_Canon_3520_01"
	"\\asmtwmfd01\Tainan_TR_Canon_3520_01"
	"\\twvwpunifsrv01\TW-Canon-BW"
	"\\twvwpunifsrv01\TW-Canon-Color"
	) do (
	echo Removing %%p
	rundll32 printui.dll,PrintUIEntry /dn /q /n %%p
	)

echo 5. resetting ASMT Canon printer connections.
REM rundll32 printui.dll,PrintUIEntry /dn /q /n"\\twvwpunifsrv01\TW-Canon-BW"
REM rundll32 printui.dll,PrintUIEntry /dn /q /n"\\twvwpunifsrv01\TW-Canon-Color"
REM rundll32 printui.dll PrintUIEntry /in /q /n"\\twvwpunifsrv01\TW-Canon-BW"
REM rundll32 printui.dll PrintUIEntry /in /y /q /n"\\twvwpunifsrv01\TW-Canon-BW"
REM rundll32 printui.dll PrintUIEntry /in /q /n"\\twvwpunifsrv01\TW-Canon-Color"

echo 6. Script completed.
pause
exit