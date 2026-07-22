@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Restart Windows Explorer

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool restarts Windows Explorer.
echo.
echo Use this tool if:
echo.
echo - Taskbar is frozen
echo - Desktop icons disappeared
echo - File Explorer is not responding
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Stopping Explorer...
taskkill /F /IM explorer.exe

timeout /t 2 >nul

echo.
echo Starting Explorer...
start explorer.exe

echo.
echo ============================================================
echo Windows Explorer restarted successfully.
echo ============================================================

pause
exit /b