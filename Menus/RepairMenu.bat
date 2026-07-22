@echo off
setlocal

call "%~dp0..\Assets\Config.bat"

:MENU

set WT_TITLE=Repair

call "%~dp0..\Assets\Header.bat"

echo.
echo 1. Repair Windows (DISM + SFC)
echo.
echo 2. Check Disk
echo.
echo 3. Enable System Restore
echo.
echo 4. Repair Printer Spooler
echo.
echo 0. Back
echo.
echo ============================================================

choice /C 12340 /N /M "Select: "

if errorlevel 5 goto BACK
if errorlevel 4 goto PRINTER
if errorlevel 3 goto RESTORE
if errorlevel 2 goto CHKDSK
if errorlevel 1 goto REPAIR

:REPAIR
call "%~dp0..\Modules\Repair\RepairWindows.bat"
goto MENU

:CHKDSK
call "%~dp0..\Modules\Repair\CheckDisk.bat"
goto MENU

:RESTORE
call "%~dp0..\Modules\Repair\EnableSystemRestore.bat"
goto MENU

:PRINTER
call "%~dp0..\Modules\Repair\RepairPrinterSpooler.bat"
goto MENU

:BACK
exit /b