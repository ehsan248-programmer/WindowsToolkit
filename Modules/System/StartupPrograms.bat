@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=Startup Programs

call "%~dp0..\..\Assets\Header.bat"

echo ============================================================
echo Startup Programs
echo ============================================================
echo.

echo -------- Registry (Current User) --------
echo.

reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul

echo.
echo -------- Registry (Local Machine) --------
echo.

reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul

echo.
echo -------- Startup Folder (Current User) --------
echo.

dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /b

echo.
echo -------- Startup Folder (All Users) --------
echo.

dir "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp" /b

echo.
echo ============================================================
echo End of List
echo ============================================================

pause
exit /b