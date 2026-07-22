@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Flush DNS Cache

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool clears the Windows DNS Resolver Cache.
echo.
echo Use this tool if:
echo.
echo - Websites do not open correctly.
echo - DNS records are outdated.
echo - Internet problems occur after changing DNS.
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Flushing DNS Cache...
echo.

ipconfig /flushdns

echo.
echo ============================================================
echo DNS Cache cleared successfully.
echo ============================================================

pause
exit /b