@echo off
goto :eof

::=====================================================
:CheckAdmin
::=====================================================

net session >nul 2>&1

if %errorlevel% neq 0 (

    color 0C

    echo.
    echo ============================================================
    echo Administrator privileges are required.
    echo ============================================================
    echo.

    pause
    exit /b
)

exit /b



::=====================================================
:CreateFolders
::=====================================================

if not exist "%WT_LOGS%" mkdir "%WT_LOGS%"
if not exist "%WT_REPORTS%" mkdir "%WT_REPORTS%"
if not exist "%WT_TEMP%" mkdir "%WT_TEMP%"

exit /b



::=====================================================
:Pause
::=====================================================

echo.
pause
exit /b



::=====================================================
:Title
::=====================================================

title %WT_NAME% %WT_VERSION%
exit /b