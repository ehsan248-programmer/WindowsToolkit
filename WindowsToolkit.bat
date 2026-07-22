setlocal EnableDelayedExpansion
@echo off
call "%~dp0Assets\CheckOS.bat"


if not defined WT_MAX (
    set WT_MAX=1
    start "" /MAX cmd /k ""%~f0""
    exit
)

title Windows Toolkit 2.0
mode con cols=100 lines=80
color 0F
::------------------------------------------------------------
:: Restart as Administrator
::------------------------------------------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrator privileges...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
setlocal EnableDelayedExpansion

call "%~dp0Assets\Config.bat"




cls
goto MainMenu

:: ============================================================
:: Check Administrator
:: ============================================================

net session >nul 2>&1

if errorlevel 1 (
    color 0C
    cls
    echo.
    echo ============================================================
    echo.
    echo        Administrator privileges are required.
    echo.
    echo   Please run WindowsToolkit.bat as Administrator.
    echo.
    echo ============================================================
    echo.
    pause
    exit
)



:: Administrator Status
net session >nul 2>&1
if %errorlevel%==0 (
    set WT_ADMIN=YES
) else (
    set WT_ADMIN=NO
)


:MainMenu



REM =========================================================================================

call :CreateFolders


for %%F in ("%~f0") do set "WT_BUILD=%%~tF"

call "%~dp0Assets\Header.bat"

echo =====================================================================================
echo  Main Menu
echo =====================================================================================

@REM echo.
echo  1. Repair Tools
echo  2. Network Tools
echo  3. Maintenance Tools
echo  4. Windows Tools
echo  5. System Tools
echo  6. Customization Tools
echo  7. Hardware / Software Info

echo.
echo  8. About
echo  0. Exit
@REM echo
echo =====================================================================================

choice /C 123456780 /N /M " Select: "

if errorlevel 9 goto ExitProgram
if errorlevel 8 goto About

if errorlevel 7 goto HardwareInfo
if errorlevel 6 goto Customization
if errorlevel 5 goto System
if errorlevel 4 goto Tools
if errorlevel 3 goto Maintenance
if errorlevel 2 goto Network
if errorlevel 1 goto Repair

:Repair
call "%~dp0Menus\RepairMenu.bat"
goto MainMenu

:Network
call "%~dp0Menus\NetworkMenu.bat"
goto MainMenu

:Maintenance

call "%~dp0Menus\MaintenanceMenu.bat"
goto MainMenu


:System
call "%~dp0Menus\SystemMenu.bat"
goto MainMenu


:Reports
echo.
echo Reports Menu (Coming Soon...)
pause
goto MainMenu

:Tools

call "%~dp0Menus\WindowsToolsMenu.bat"
goto MainMenu


:Customization

call "%~dp0Menus\CustomizationToolsMenu.bat"
goto MainMenu




REM call "%~dp0Menus\About.bat"
REM goto MainMenu

:HardwareInfo
cls
call "%~dp0Assets\HardwareInfo.bat"
goto MainMenu

:About
call "%~dp0Menus\About.bat"
goto MainMenu

:ExitProgram
exit

:CreateFolders
if not exist "%WT_LOGS%" mkdir "%WT_LOGS%"
if not exist "%WT_REPORTS%" mkdir "%WT_REPORTS%"
if not exist "%WT_TEMP%" mkdir "%WT_TEMP%"
exit /b

:BytesToGB

if "%1"=="1073741824" set "%2=1"
if "%1"=="2147483648" set "%2=2"
if "%1"=="4294967296" set "%2=4"
if "%1"=="8589934592" set "%2=8"
if "%1"=="17179869184" set "%2=16"
if "%1"=="34359738368" set "%2=32"
if "%1"=="68719476736" set "%2=64"

exit /b