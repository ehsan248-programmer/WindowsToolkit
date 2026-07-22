@echo off

call "%~dp0..\Assets\Config.bat"

set WT_TITLE=About

call "%~dp0..\Assets\Header.bat"

echo.
echo ============================================================
echo                     Windows Toolkit
echo ============================================================
echo.
echo Version             : 2.0
echo Build               : 100
echo.
echo Developer           : Ehsan Younesi Moghaddam
echo.
echo Language            : Batch + PowerShell
echo.
echo Batch Files         : %BATCHCOUNT%
echo PowerShell Files    : %PSCOUNT%
echo Modules             : %MODULECOUNT%
echo.
echo ------------------------------------------------------------
echo.
echo Compatible With
echo.
echo    Windows 7
echo    Windows 8
echo    Windows 8.1
echo    Windows 10
echo    Windows 11
echo.
echo    Windows Server 2012
echo    Windows Server 2016
echo    Windows Server 2019
echo    Windows Server 2022
echo.
echo ------------------------------------------------------------
echo.
echo Features
echo.
echo   Repair Tools
echo   Network Tools
echo   Maintenance Tools
echo   Windows Tools
echo   System Information
echo   Windows Activation Status
echo   Office Activation Status
echo   SMART Disk Health
echo   Startup Programs
echo   Installed Software
echo   Export System Information
echo   One Click Maintenance
echo.
echo ============================================================
echo.

pause
exit /b