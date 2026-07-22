@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Reset TCP/IP

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool resets the Windows TCP/IP Stack.
echo.
echo It restores the default TCP/IP configuration.
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Resetting TCP/IP...
echo.

netsh int ip reset

echo.
echo ============================================================
echo TCP/IP reset completed.
echo.
echo A system restart is recommended.
echo ============================================================

pause
exit /b