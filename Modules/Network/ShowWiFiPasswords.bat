@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Show Wi-Fi Passwords

call "%~dp0..\..\Assets\Header.bat"

echo Saved Wi-Fi Profiles
echo.
echo ============================================================
echo.

netsh wlan show profiles

echo.
echo ============================================================
echo.

set /p PROFILE=Enter Wi-Fi Profile Name: 

if "%PROFILE%"=="" exit /b

echo.
echo ============================================================
echo Password Information
echo ============================================================
echo.

netsh wlan show profile name="%PROFILE%" key=clear

echo.
pause
exit /b