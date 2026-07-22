@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Check Disk

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo Check Disk scans the selected drive for file system errors.
echo.
echo If the drive is in use, Windows will schedule the scan
echo for the next system restart.
echo.
echo ============================================================

set /p DRIVE=Enter Drive Letter (Example C): 

if "%DRIVE%"=="" exit /b

echo.
echo Selected Drive : %DRIVE%:
echo.

choice /C YN /N /M "Run CHKDSK on %DRIVE%: ? (Y/N): "

if errorlevel 2 exit /b

echo.
echo ============================================================
echo Running CHKDSK...
echo ============================================================
echo.

chkdsk %DRIVE%: /F

echo.
echo ============================================================
echo Operation completed.
echo ============================================================

pause
exit /b