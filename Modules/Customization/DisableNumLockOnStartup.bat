@echo off
title Disable NumLock on Startup

REM reg add "HKU\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 0 /f >nul
REM reg add "HKCU\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 0 /f >nul

call "%~dp0..\..\Assets\ImportReg.bat" "%~dp0..\..\Reg\Keyboard\DisableNumLock.reg"

echo.
echo NumLock will be Disabled at Windows startup.
pause