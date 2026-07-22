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
echo 2. Clear Update Cache
echo 3. Restart Services
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo ============================================================
echo Stopping Services...
echo ============================================================
echo.

net stop wuauserv
net stop bits
net stop cryptsvc
net stop msiserver

echo.
echo ============================================================
echo Removing Windows Update Cache...
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
echo Starting Services...
echo ============================================================
echo.

net start cryptsvc
net start bits
net start msiserver
net start wuauserv

echo.
echo ============================================================
echo Windows Update has been reset successfully.
echo.
echo A system restart is recommended.
echo ============================================================

pause
exit /b