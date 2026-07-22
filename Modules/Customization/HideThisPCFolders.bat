@echo off
title Hide This PC Folders

REM reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

call "%~dp0..\..\Assets\ImportReg.bat" "%~dp0..\..\Reg\Explorer\HideThisPCFolders.reg"


echo.
echo This PC folders have been hidden.
echo Restarting Explorer...

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
pause