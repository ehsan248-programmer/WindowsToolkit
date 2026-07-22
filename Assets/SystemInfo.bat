@echo off

:: ==========================================
:: Windows Toolkit - System Information
:: ==========================================

:: Computer Name
set "WT_PC=%COMPUTERNAME%"

:: Current User
set "WT_USER=%USERNAME%"

:: Administrator
net session >nul 2>&1
if %errorlevel%==0 (
    set "WT_ADMIN=YES"
) else (
    set "WT_ADMIN=NO"
)

:: Windows Caption
for /f "skip=1 delims=" %%i in ('wmic os get Caption') do (
    if not "%%i"=="" (
        set "WT_OS=%%i"
        goto :OSDONE
    )
)
:OSDONE

:: Windows Build
for /f "skip=1" %%i in ('wmic os get BuildNumber') do (
    if not "%%i"=="" (
        set "WT_BUILDNUM=%%i"
        goto :BUILDDONE
    )
)
:BUILDDONE

:: CPU
for /f "skip=1 delims=" %%i in ('wmic cpu get Name') do (
    if not "%%i"=="" (
        set "WT_CPU=%%i"
        goto :CPUDONE
    )
)
:CPUDONE

:: RAM (GB)
for /f %%i in ('powershell -NoProfile -Command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"') do (
    set "WT_RAM=%%i GB"
)

:: Drive C Free Space
for /f %%i in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free/1GB,1)"') do (
    set "WT_CFREE=%%i GB"
)

exit /b