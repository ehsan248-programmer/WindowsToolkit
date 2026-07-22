@echo off

title Windows Toolkit 2.0

color 0B

REM for /f "tokens=3*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>nul') do (
    REM set "WT_OS=%%A %%B"
REM )

REM cls

cls
REM echo HEADER STARTED


echo =====================================================================================
REM echo                 Windows Toolkit 2.0
REM echo                      Build 101
REM echo ============================================================

echo.
echo  Name          : %WT_NAME% (%WT_STATUS%)
echo  Version       : %WT_VERSION%
echo  Build         : %WT_BUILD%
REM echo  Status        : %WT_STATUS%
echo.
REM echo.
REM echo  Computer  : %COMPUTERNAME%
REM echo  User      : %USERNAME%
REM echo  Windows   : %WT_OS%
REM echo.
REM echo ============================================================
REM echo boooos
if defined WT_TITLE (
echo  %WT_TITLE%
echo =====================================================================================
)

exit /b