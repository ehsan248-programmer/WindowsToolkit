@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Export Wi-Fi Passwords

call "%~dp0..\..\Assets\Header.bat"

set OUTFILE=%WT_REPORTS%\WiFiPasswords.txt

if not exist "%WT_REPORTS%" mkdir "%WT_REPORTS%"

echo Windows Toolkit Wi-Fi Password Report > "%OUTFILE%"
echo ======================================>>"%OUTFILE%"
echo.>>"%OUTFILE%"

echo Exporting Wi-Fi profiles...
echo.

for /f "skip=9 tokens=1,2,*" %%A in ('netsh wlan show profiles') do (

    if not "%%C"=="" (

        echo ======================================>>"%OUTFILE%"
        echo Profile: %%C>>"%OUTFILE%"
        echo ======================================>>"%OUTFILE%"

        netsh wlan show profile name="%%C" key=clear >> "%OUTFILE%"

        echo.>>"%OUTFILE%"
    )

)

echo.
echo ============================================================
echo Export Completed.
echo.
echo File Saved:
echo %OUTFILE%
echo ============================================================

pause
exit /b