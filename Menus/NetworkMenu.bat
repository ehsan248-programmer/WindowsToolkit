@echo off
setlocal

call "%~dp0..\Assets\Config.bat"

:MENU

set WT_TITLE=Network

call "%~dp0..\Assets\Header.bat"

echo.
echo 1. Automatic Network Repair
echo.
echo 2. Flush DNS Cache
echo.
echo 3. Renew IP Address
echo.
echo 4. Reset Winsock
echo.
echo 5. Reset TCP/IP
echo.
echo 6. Show Wi-Fi Passwords
echo.
echo 7. Export Wi-Fi Passwords
echo.
echo 8. Network Information
echo.
echo 0. Back
echo.
echo ============================================================

choice /C 123456780 /N /M "Select: "

if errorlevel 9 goto BACK
if errorlevel 8 goto INFO
if errorlevel 7 goto EXPORT
if errorlevel 6 goto SHOWPASS
if errorlevel 5 goto TCPIP
if errorlevel 4 goto WINSOCK
if errorlevel 3 goto RENEW
if errorlevel 2 goto FLUSHDNS
if errorlevel 1 goto REPAIR

:REPAIR
call "%~dp0..\Modules\Network\NetworkRepair.bat"
goto MENU

:FLUSHDNS
call "%~dp0..\Modules\Network\FlushDNS.bat"
goto MENU

:RENEW
call "%~dp0..\Modules\Network\RenewIP.bat"
goto MENU

:WINSOCK
call "%~dp0..\Modules\Network\ResetWinsock.bat"
goto MENU

:TCPIP
call "%~dp0..\Modules\Network\ResetTCPIP.bat"
goto MENU

:SHOWPASS
call "%~dp0..\Modules\Network\ShowWifiPasswords.bat"
goto MENU

:EXPORT
call "%~dp0..\Modules\Network\ExportWifiPasswords.bat"
goto MENU

:INFO
call "%~dp0..\Modules\Network\NetworkInfo.bat"
goto MENU

:BACK
exit /b