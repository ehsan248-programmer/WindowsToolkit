@echo off
setlocal

call "%~dp0..\Assets\Config.bat"

:MENU

set WT_TITLE=Windows Tools

call "%~dp0..\Assets\Header.bat"

echo.
echo 1. System Configuration (MSConfig)
echo.
echo 2. Registry Editor (Regedit)
echo.
echo 3. Device Manager (devmgmt.msc)
echo.
echo 4. Services (services.msc)
echo.
echo 5. Disk Management (diskmgmt.msc)
echo.
echo 6. Computer Management (compmgmt.msc)
echo.
echo 7. Event Viewer (eventvwr.msc)
echo.
echo 8. Task Scheduler (taskschd.msc)
echo.
echo 9. System Information (msinfo32)
echo.
echo A. Resource Monitor (resmon)
echo.
echo B. Windows Features (optionalfeatures)
echo.
echo C. Programs and Features (appwiz.cpl)
echo.
echo D. Network Adapters Manager (ncpa.cpl)
echo.
echo E. FIREWALL (firewall.cpl)
echo.
echo F. DATE TIME (timeda.cpl)
echo.
echo G. Task Manager (taskmgr)
echo.
echo 0. Back
echo.
echo ============================================================

choice /C 123456789ABCDEFG0 /N /M "Select: "

if errorlevel 17 goto BACK
if errorlevel 16 goto TASKMGR
if errorlevel 15 goto TIMEDATE
if errorlevel 14 goto FIREWALL
if errorlevel 13 goto NETWORKADAPTER

if errorlevel 12 goto APPWIZ
if errorlevel 11 goto FEATURES
if errorlevel 10 goto RESMON
if errorlevel 9 goto MSINFO
if errorlevel 8 goto TASKSCHD
if errorlevel 7 goto EVENTVWR
if errorlevel 6 goto COMPMGMT
if errorlevel 5 goto DISKMGMT
if errorlevel 4 goto SERVICES
if errorlevel 3 goto DEVMGMT
if errorlevel 2 goto REGEDIT
if errorlevel 1 goto MSCONFIG

:MSCONFIG
start msconfig
goto MENU

:REGEDIT
start regedit
goto MENU

:DEVMGMT
start devmgmt.msc
goto MENU

:SERVICES
start services.msc
goto MENU

:DISKMGMT
start diskmgmt.msc
goto MENU

:COMPMGMT
start compmgmt.msc
goto MENU

:EVENTVWR
start eventvwr.msc
goto MENU

:TASKSCHD
start taskschd.msc
goto MENU

:MSINFO
start msinfo32
goto MENU

:RESMON
start resmon
goto MENU

:FEATURES
start optionalfeatures
goto MENU

:APPWIZ
start appwiz.cpl
goto MENU

:TASKMGR
start taskmgr
goto MENU

:NETWORKADAPTER
start ncpa.cpl
goto MENU


:FIREWALL
start firewall.cpl
goto MENU

:TIMEDATE
start timedate.cpl
goto MENU

:BACK
exit /b