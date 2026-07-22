EnergyReport.bat@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Energy Report

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool analyzes power efficiency and
echo generates a Windows Energy Report.
echo.
echo This process takes about 60 seconds.
echo.
echo ============================================================

choice /C YN /N /M "Generate Report (Y/N)? "

if errorlevel 2 exit /b

if not exist "%WT_REPORTS%" mkdir "%WT_REPORTS%"

powercfg /energy /output "%WT_REPORTS%\EnergyReport.html"

echo.
echo ============================================================
echo Report saved to:
echo.
echo %WT_REPORTS%\EnergyReport.html
echo ============================================================

pause
exit /b