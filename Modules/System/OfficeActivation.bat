@echo off
setlocal EnableDelayedExpansion

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Office Activation Status

call "%~dp0..\..\Assets\Header.bat"

echo.
echo Searching for Microsoft Office...
echo.

set FOUND=0

call :Check Office14
call :Check Office15
call :Check Office16
call :Check root\Office16

if "%FOUND%"=="0" (
    echo.
    echo No supported Microsoft Office installation found.
    echo.
    pause
    exit /b
)

pause
exit /b


::============================================================

:Check

if exist "%ProgramFiles%\Microsoft Office\%~1\OSPP.VBS" (
    call :Show "%ProgramFiles%\Microsoft Office\%~1\OSPP.VBS"
)

if exist "%ProgramFiles(x86)%\Microsoft Office\%~1\OSPP.VBS" (
    call :Show "%ProgramFiles(x86)%\Microsoft Office\%~1\OSPP.VBS"
)

exit /b

::============================================================

:Show

set FOUND=1

echo ============================================================
echo Office Installation
echo ============================================================

for /f "delims=" %%i in ('cscript //nologo %1 /dstatus ^| findstr /I "LICENSE NAME:"') do echo %%i

for /f "delims=" %%i in ('cscript //nologo %1 /dstatus ^| findstr /I "LICENSE STATUS:"') do echo %%i

for /f "delims=" %%i in ('cscript //nologo %1 /dstatus ^| findstr /I "Last 5 characters"') do echo %%i

for /f "delims=" %%i in ('cscript //nologo %1 /dstatus ^| findstr /I "REMAINING GRACE"') do echo %%i

echo.
exit /b