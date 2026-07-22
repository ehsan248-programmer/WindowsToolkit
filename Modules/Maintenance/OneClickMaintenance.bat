@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=One Click Maintenance

call "%~dp0..\..\Assets\Header.bat"

echo ============================================================
echo One Click Maintenance
echo ============================================================
echo.
echo The following maintenance tasks will be executed:
echo.
echo   1. Clear Temporary Files
echo   2. Flush DNS Cache
echo   3. Empty Recycle Bin
echo   4. Restart Windows Explorer
echo   5. Reset Windows Update
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo ============================================================
echo [1/5] Clearing Temporary Files...
echo ============================================================
call "%~dp0ClearTemp.bat"

echo.
echo ============================================================
echo [2/5] Flushing DNS Cache...
echo ============================================================
ipconfig /flushdns

echo.
echo ============================================================
echo [3/5] Emptying Recycle Bin...
echo ============================================================
PowerShell -NoProfile -Command "Clear-RecycleBin -Force" >nul 2>&1

echo.
echo ============================================================
echo [4/5] Restarting Windows Explorer...
echo ============================================================
taskkill /F /IM explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe

echo.
echo ============================================================
echo [5/5] Resetting Windows Update...
echo ============================================================
call "%~dp0WindowsUpdateReset.bat"

echo.
echo ============================================================
echo One Click Maintenance Completed Successfully.
echo.
echo It is recommended to restart your computer.
echo ============================================================

pause
exit /b