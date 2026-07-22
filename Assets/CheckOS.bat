@echo off
setlocal

rem ===========================================================
rem Get Windows Build Number
rem ===========================================================

set "BUILD="

for /f "tokens=3" %%A in ('
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild 2^>nul ^| find "CurrentBuild"
') do (
    set "BUILD=%%A"
)

if not defined BUILD exit /b 0

rem ===========================================================
rem Show Warning For Older Windows
rem ===========================================================

if %BUILD% LSS 10240 (

    cls
    color 0E

    echo.
    echo ===============================================================
    echo                     Windows Toolkit 2.0
    echo ===============================================================
    echo.
    echo   Recommended Operating Systems:
    echo.
    echo      [✓] Windows 10
    echo      [✓] Windows 11
    echo      [✓] Windows Server 2016+
    echo.
    echo   Warning:
    echo.
    echo   Some features may not work correctly on
    echo   this version of Windows.
    echo.
    echo   For the best experience,
    echo   Windows 10 or newer is recommended.
    echo.
    echo ===============================================================
    echo.
    timeout /t 5 >nul
)

exit /b 0