@echo off
setlocal EnableDelayedExpansion

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Installed Software

call "%~dp0..\..\Assets\Header.bat"

if not exist "%WT_REPORTS%" mkdir "%WT_REPORTS%"

set REPORT=%WT_REPORTS%\InstalledSoftware.txt

echo ============================================================
echo Exporting Installed Software...
echo ============================================================
echo.

echo Windows Toolkit > "%REPORT%"
echo Installed Software List >> "%REPORT%"
echo ============================================================>>"%REPORT%"
echo.>>"%REPORT%"

echo Installed Software
echo ============================================================
echo.

call :ReadKey "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
call :ReadKey "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

echo.
echo ============================================================
echo Report Saved:
echo %REPORT%
echo ============================================================

pause
exit /b


:ReadKey

for /f "delims=" %%K in ('reg query %1 2^>nul') do (

    set NAME=
    set VER=

    for /f "tokens=2,*" %%A in ('reg query "%%K" /v DisplayName 2^>nul ^| find "DisplayName"') do (
        set NAME=%%B
    )

    if defined NAME (

        for /f "tokens=2,*" %%A in ('reg query "%%K" /v DisplayVersion 2^>nul ^| find "DisplayVersion"') do (
            set VER=%%B
        )

        echo !NAME!    !VER!
        echo !NAME!    !VER!>>"%REPORT%"
    )

)

exit /b