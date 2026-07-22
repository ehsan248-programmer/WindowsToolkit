@echo off
setlocal

call "%~dp0..\Assets\Config.bat"

:MENU

set WT_TITLE=Maintenance

call "%~dp0..\Assets\Header.bat"

echo.
echo ================= Maintenance =================
echo.
echo 1. Clear Temporary Files
echo.
echo 2. Restart Windows Explorer
echo.
echo 3. Empty Recycle Bin
echo.
echo 4. Battery Report
echo.
echo 5. Energy Report
echo.
echo 6. Windows Update Reset
echo.
echo 7. Repair Windows Update
echo.
echo 8. Create Restore Point
echo.
echo 9. One Click Maintenance
echo.
echo 0. Back
echo.
echo ============================================================

choice /C 1234567890 /N /M "Select: "

if errorlevel 10 goto BACK
if errorlevel 9 goto ONECLICK
if errorlevel 8 goto RESTORE
if errorlevel 7 goto REPAIRWU
if errorlevel 6 goto RESETWU
if errorlevel 5 goto ENERGY
if errorlevel 4 goto BATTERY
if errorlevel 3 goto RECYCLE
if errorlevel 2 goto EXPLORER
if errorlevel 1 goto TEMP

:TEMP
call "%~dp0..\Modules\Maintenance\ClearTemp.bat"
goto MENU

:EXPLORER
call "%~dp0..\Modules\Maintenance\RestartExplorer.bat"
goto MENU

:RECYCLE
call "%~dp0..\Modules\Maintenance\EmptyRecycleBin.bat"
goto MENU

:BATTERY
call "%~dp0..\Modules\Maintenance\BatteryReport.bat"
goto MENU

:ENERGY
call "%~dp0..\Modules\Maintenance\EnergyReport.bat"
goto MENU

:RESETWU
call "%~dp0..\Modules\Maintenance\WindowsUpdateReset.bat"
goto MENU

:REPAIRWU
call "%~dp0..\Modules\Maintenance\RepairWindowsUpdate.bat"
goto MENU

:RESTORE
call "%~dp0..\Modules\Maintenance\CreateRestorePoint.bat"
goto MENU

:ONECLICK
call "%~dp0..\Modules\Maintenance\OneClickMaintenance.bat"
goto MENU

:BACK
exit /b