@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Clear Temporary Files

call "%~dp0..\..\Assets\Header.bat"

echo Description:
echo.
echo This tool removes temporary files from:
echo.
echo - Windows Temp
echo - User Temp
echo - Prefetch
echo.
echo Some files currently in use may not be deleted.
echo.
echo ============================================================

choice /C YN /N /M "Continue (Y/N)? "

if errorlevel 2 exit /b

echo.
echo Cleaning User Temp...
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" >nul 2>&1

echo.
echo Cleaning Windows Temp...
del /f /s /q "%windir%\Temp\*" >nul 2>&1
for /d %%i in ("%windir%\Temp\*") do rd /s /q "%%i" >nul 2>&1

echo.
echo Cleaning Prefetch...
del /f /q "%windir%\Prefetch\*" >nul 2>&1

echo.
echo ============================================================
echo Temporary files cleaned successfully.
echo ============================================================

pause
exit /b