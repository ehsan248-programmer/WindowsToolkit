@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Automatic Network Repair

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool performs a complete network repair.
echo.
echo It will execute:
echo.
echo 1. Flush DNS Cache
echo 2. Release IP Address
echo 3. Renew IP Address
echo 4. Reset Winsock
echo 5. Reset TCP/IP
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Flushing DNS...
ipconfig /flushdns

echo.
echo Releasing IP...
ipconfig /release

echo.
echo Renewing IP...
ipconfig /renew

echo.
echo Resetting Winsock...
netsh winsock reset

echo.
echo Resetting TCP/IP...
netsh int ip reset

echo.
echo ============================================================
echo Network repair completed.
echo.
echo A system restart is recommended.
echo ============================================================

pause
exit /b