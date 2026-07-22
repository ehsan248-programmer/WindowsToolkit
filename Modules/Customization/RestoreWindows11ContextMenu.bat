@echo off
title Restore Windows 11 Context Menu

REM reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
call "%~dp0..\..\Assets\ImportReg.bat" "%~dp0..\..\Reg\Explorer\RestoreWindows11Context.reg"

echo.
echo Windows 11 Context Menu Restored.
echo Restarting Explorer...

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
pause