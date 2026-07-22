@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Enable System Restore

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool enables System Protection
echo on drive C: and creates a Restore Point.
echo.
echo Windows System Restore allows you to
echo restore your computer to a previous state.
echo.
echo ============================================================

choice /C YN /N /M "Enable System Restore? (Y/N): "

if errorlevel 2 exit /b

echo.
echo Enabling System Protection...
echo.

powershell -Command "Enable-ComputerRestore -Drive 'C:\'"


echo.
echo Creating Restore Point...
echo.

powershell -Command "Checkpoint-Computer -Description 'Windows Toolkit Restore Point' -RestorePointType MODIFY_SETTINGS"

echo.

echo ============================================================
echo System Restore completed.
echo ============================================================

pause
exit /b