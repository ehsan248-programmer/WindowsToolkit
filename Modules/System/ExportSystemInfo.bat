@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Export System Information

call "%~dp0..\..\Assets\Header.bat"

echo.
echo Creating System Report...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0ExportSystemInfo.ps1"

echo.
pause