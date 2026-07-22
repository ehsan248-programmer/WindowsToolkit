@echo off

call "%~dp0..\..\Assets\Config.bat"

set WT_TITLE=SMART Disk Health

call "%~dp0..\..\Assets\Header.bat"

echo.
echo Reading SMART Information...
echo.
echo ============================================================
echo.

wmic diskdrive get Model,InterfaceType,MediaType,Size,Status

echo.
echo ============================================================
echo.

echo Logical Drives
echo.
wmic logicaldisk get DeviceID,VolumeName,FileSystem,FreeSpace,Size

echo.
echo ============================================================
echo.

pause
exit /b