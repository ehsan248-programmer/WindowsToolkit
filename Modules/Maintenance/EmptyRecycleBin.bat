@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Empty Recycle Bin

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool permanently empties the Recycle Bin.
echo.
echo Deleted files cannot be recovered afterwards.
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Emptying Recycle Bin...
echo.

PowerShell -NoProfile -Command "Clear-RecycleBin -Force" >nul 2>&1

echo.
echo ============================================================
echo Recycle Bin emptied successfully.
echo ============================================================

pause
exit /b