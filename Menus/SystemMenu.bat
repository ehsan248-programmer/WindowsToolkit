@echo off
setlocal

call "%~dp0..\Assets\Config.bat"

:MENU

set WT_TITLE=System Tools

call "%~dp0..\Assets\Header.bat"

echo.
echo ================= System Tools =================
echo.
echo 1. Windows Activation Status
echo.
echo 2. Office Activation Status
echo.
echo 3. SMART Disk Health
echo.
echo 4. Export System Information
echo.
echo 5. Installed Software List
echo.
echo 6. Startup Programs
echo.
echo 0. Back
echo.
echo ============================================================

choice /C 1234560 /N /M "Select: "

if errorlevel 7 goto BACK
if errorlevel 6 goto STARTUP
if errorlevel 5 goto SOFTWARE
if errorlevel 4 goto EXPORT
if errorlevel 3 goto SMART
if errorlevel 2 goto OFFICE
if errorlevel 1 goto WINDOWS

:WINDOWS
call "%~dp0..\Modules\System\WindowsActivation.bat"
goto MENU

:OFFICE
call "%~dp0..\Modules\System\OfficeActivation.bat"
goto MENU

:SMART
call "%~dp0..\Modules\System\SmartDiskHealth.bat"
goto MENU

:EXPORT
call "%~dp0..\Modules\System\ExportSystemInfo.bat"
goto MENU

:SOFTWARE
call "%~dp0..\Modules\System\InstalledSoftware.bat"
goto MENU

:STARTUP
call "%~dp0..\Modules\System\StartupPrograms.bat"
goto MENU

:BACK
exit /b