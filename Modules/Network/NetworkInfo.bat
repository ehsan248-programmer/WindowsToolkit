@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Network Information

call "%~dp0..\..\Assets\Header.bat"

echo Network Configuration
echo.
echo ============================================================
echo.

ipconfig /all

echo.
echo ============================================================
echo.

pause
exit /b