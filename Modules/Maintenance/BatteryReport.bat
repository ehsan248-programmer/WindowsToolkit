@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Battery Report

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool generates a Windows Battery Report.
echo.
echo ============================================================

choice /C YN /N /M "Generate Report (Y/N)? "

if errorlevel 2 exit /b

if not exist "%WT_REPORTS%" mkdir "%WT_REPORTS%"

powercfg /batteryreport /output "%WT_REPORTS%\BatteryReport.html"

echo.
echo ============================================================
echo Report saved to:
echo.
echo %WT_REPORTS%\BatteryReport.html
echo ============================================================

pause
exit /b