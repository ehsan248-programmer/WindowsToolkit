@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Repair Windows

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool repairs Windows system files.
echo.
echo Step 1:
echo   DISM checks and repairs the Windows Component Store.
echo.
echo Step 2:
echo   SFC scans and repairs protected system files.
echo.
echo This process may take several minutes.
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

cls

call "%~dp0..\..\Assets\Header.bat"

echo.
echo ============================================================
echo Step 1 of 2
echo Running DISM...
echo ============================================================
echo.

DISM /Online /Cleanup-Image /RestoreHealth

echo.

if errorlevel 1 (
    echo.
    echo DISM finished with errors.
) else (
    echo.
    echo DISM completed successfully.
)

echo.
echo ============================================================
echo Step 2 of 2
echo Running System File Checker...
echo ============================================================
echo.

sfc /scannow

echo.

if errorlevel 1 (
    echo.
    echo SFC finished with errors.
) else (
    echo.
    echo SFC completed successfully.
)

echo.
echo ============================================================
echo Repair operation finished.
echo ============================================================

pause

exit /b