@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Create Restore Point

call "%~dp0..\..\Assets\Header.bat"

echo ============================================================
echo Create Restore Point
echo ============================================================
echo.

echo This tool creates a new System Restore Point.
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Creating Restore Point...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Checkpoint-Computer -Description 'Windows Toolkit Restore Point' -RestorePointType MODIFY_SETTINGS"

if %errorlevel%==0 (
    echo.
    echo ============================================================
    echo Restore Point created successfully.
    echo ============================================================
) else (
    echo.
    echo ============================================================
    echo Failed to create Restore Point.
    echo.
    echo Possible reasons:
    echo.
    echo - System Protection is disabled.
    echo - Windows has reached the restore point limit.
    echo - Administrator privileges are required.
    echo ============================================================
)

pause
exit /b