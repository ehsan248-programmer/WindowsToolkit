@echo off
setlocal

call "%~dp0..\Assets\Config.bat"

:MENU

set WT_TITLE=System Tools

call "%~dp0..\Assets\Header.bat"

echo.
echo ================= System Tools =================
echo.
echo 1. Enable Classic Context Menu (Windows 10 Style)
echo.
echo 2. Restore Windows 11 Context Menu
echo.
echo 3. Enable NumLock On Startup
echo.
echo 4. Disable NumLock On Startup
echo.
echo 5. Enable Network Shared Drive
echo.
echo 6. Show This PC Folders 
echo.
echo 7. Hide This PC Folders 
echo.
echo 0. Back
echo.
echo ============================================================

choice /C 12345670 /N /M "Select: "

if errorlevel 8 goto BACK
REM if errorlevel 6 goto STARTUP
if errorlevel 7 goto HideThisPCFolders
if errorlevel 6 goto ShowThisPCFolders
if errorlevel 5 goto EnableNetworkSharedDrive
if errorlevel 4 goto DisableNumLockOnStartup
if errorlevel 3 goto EnableNumLockOnStartup
if errorlevel 2 goto RestoreWindows11ContextMenu
if errorlevel 1 goto EnbaleClassicMenu

:EnbaleClassicMenu
call "%~dp0..\Modules\Customization\EnableClassicContextMenu.bat"
goto MENU

:RestoreWindows11ContextMenu
call "%~dp0..\Modules\Customization\RestoreWindows11ContextMenu.bat"
goto MENU
:EnableNumLockOnStartup
call "%~dp0..\Modules\Customization\EnableNumLockOnStartup.bat"
goto MENU
:DisableNumLockOnStartup
call "%~dp0..\Modules\Customization\DisableNumLockOnStartup.bat"
goto MENU

:EnableNetworkSharedDrive
call "%~dp0..\Modules\Customization\EnableNetworkSharedDrive.bat"
goto MENU
:ShowThisPCFolders
call "%~dp0..\Modules\Customization\ShowThisPCFolders.bat"
goto MENU
:HideThisPCFolders
call "%~dp0..\Modules\Customization\HideThisPCFolders.bat"
goto MENU

REM :SMART
REM call "%~dp0..\Modules\System\SmartDiskHealth.bat"
REM goto MENU

REM :EXPORT
REM call "%~dp0..\Modules\System\ExportSystemInfo.bat"
REM goto MENU

REM :SOFTWARE
REM call "%~dp0..\Modules\System\InstalledSoftware.bat"
REM goto MENU

REM :STARTUP
REM call "%~dp0..\Modules\System\StartupPrograms.bat"
REM goto MENU

:BACK
exit /b