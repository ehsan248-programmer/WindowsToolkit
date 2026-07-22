@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Renew IP Address

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool releases the current IP address
echo and requests a new one from the DHCP server.
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Releasing IP Address...
echo.

ipconfig /release

echo.
echo Renewing IP Address...
echo.

ipconfig /renew

echo.
echo ============================================================
echo IP Address renewed successfully.
echo ============================================================

pause
exit /b