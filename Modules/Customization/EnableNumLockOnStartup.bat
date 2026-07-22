@echo off
title Enable NumLock on Startup

REM reg add "HKU\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f >nul
REM reg add "HKCU\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f >nul

call "%~dp0..\..\Assets\ImportReg.bat" "%~dp0..\..\Reg\Keyboard\EnableNumLock.reg"


echo.
echo NumLock will be Enabled at Windows startup.
pause