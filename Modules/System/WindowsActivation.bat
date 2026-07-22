@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Windows Activation Status

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool displays the current Windows activation status.
echo.
echo ============================================================
echo.

cscript //nologo "%windir%\system32\slmgr.vbs" /xpr

echo.
echo ============================================================
echo.

cscript //nologo "%windir%\system32\slmgr.vbs" /dli

echo.
echo ============================================================
echo.

pause
exit /b