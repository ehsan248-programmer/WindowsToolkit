@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Repair Windows Update

call "%~dp0..\..\Assets\Header.bat"

echo ============================================================
echo Repair Windows Update
echo ============================================================
echo.
echo This tool will:
echo.
echo 1. Stop Windows Update Services
echo 2. Clear Windows Update Cache
echo 3. Re-register Windows Update DLLs
echo 4. Reset Winsock
echo 5. Reset Windows Update Components
echo 6. Start Windows Update Services
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
echo Clearing Update Cache...
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
echo Re-registering Windows Update Components...
echo ============================================================
echo.

regsvr32 /s wuapi.dll
regsvr32 /s wuaueng.dll
regsvr32 /s wuaueng1.dll
regsvr32 /s wucltui.dll
regsvr32 /s wups.dll
regsvr32 /s wups2.dll
regsvr32 /s wuwebv.dll
regsvr32 /s qmgr.dll
regsvr32 /s qmgrprxy.dll

echo Done.

echo.
echo ============================================================
echo Resetting Winsock...
echo ============================================================
echo.

netsh winsock reset

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
echo Repair completed successfully.
echo.
echo Please restart Windows before checking for updates.
echo ============================================================

pause
exit /b