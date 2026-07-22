@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Reset Winsock

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool resets the Windows Winsock Catalog.
echo.
echo Use this tool if:
echo.
echo - Internet connection problems occur.
echo - Network software damaged Winsock.
echo - Malware changed network settings.
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Resetting Winsock...
echo.

netsh winsock reset

echo.
echo ============================================================
echo Winsock reset completed.
echo.
echo A system restart is recommended.
echo ============================================================

pause
exit /b