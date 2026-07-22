@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Repair Printer Spooler

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool repairs the Windows Print Spooler service.
echo.
echo The following actions will be performed:
echo.
echo 1. Stop Print Spooler Service
echo 2. Delete Pending Print Jobs
echo 3. Start Print Spooler Service
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Stopping Print Spooler...
net stop spooler

echo.
echo Removing print queue...

del /Q /F "%SystemRoot%\System32\spool\PRINTERS\*.*" >nul 2>&1

echo.
echo Starting Print Spooler...
net start spooler

echo.
echo ============================================================
echo Printer Spooler repaired successfully.
echo ============================================================

pause
exit /b