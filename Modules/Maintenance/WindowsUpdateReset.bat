@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Windows Update Reset

call "%~dp0..\..\Assets\Header.bat"

echo ============================================================
echo Windows Update Reset
echo ============================================================
echo.
echo This tool will:
echo.
echo 1. Stop Windows Update Services
echo 2. Clear Windows Update Cache
echo 3. Flush DNS Cache
echo 4. Reset Winsock
echo 5. Reset TCP/IP
echo 6. Restart Windows Update Services
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo ============================================================
echo Stopping Windows Update Services...
echo ============================================================
echo.

net stop wuauserv
net stop bits
net stop cryptsvc
net stop msiserver

echo.
echo ============================================================
echo Clearing Windows Update Cache...
echo ============================================================
echo.

if exist "%windir%\SoftwareDistribution" (
    ren "%windir%\SoftwareDistribution" SoftwareDistribution.old
)

if exist "%windir%\System32\catroot2" (
    ren "%windir%\System32\catroot2" catroot2.old
)

echo.
echo ============================================================
echo Flushing DNS Cache...
echo ============================================================
echo.

ipconfig /flushdns

echo.
echo ============================================================
echo Resetting Winsock...
echo ============================================================
echo.

netsh winsock reset

echo.
echo ============================================================
echo Resetting TCP/IP...
echo ============================================================
echo.

netsh int ip reset

echo.
echo ============================================================
echo Starting Windows Update Services...
echo ============================================================
echo.

net start cryptsvc
net start bits
net start msiserver
net start wuauserv

echo.
echo ============================================================
echo Windows Update Reset Completed Successfully.
echo.
echo It is recommended to restart your computer.
echo ============================================================

pause
exit /b