
@echo off
REM echo Please wait... Retrieving hardware and software information. This may take a few minutes
REM echo ----------------------------------------------------------------------------------------

REM ====================================================================================================
call "%~dp0..\Assets\Config.bat"
call "%~dp0..\Assets\Header.bat"
REM ====================================================================================================
:: Administrator
net session >nul 2>&1
if %errorlevel%==0 (
    set "WT_ADMIN=YES"
) else (
    set "WT_ADMIN=NO"
)

:: Computer
set "WT_PC=%COMPUTERNAME%"
set "WT_USER=%USERNAME%"

REM echo =====================================================================================
REM echo  System      Information
echo =====================================================================================
REM echo Detecting System Information...
REM ====================================================================================================
for /f "tokens=1,* delims==" %%A in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetSystemInfo.ps1"
') do (
    set "%%A=%%B"
)
REM ====================================================================================================

echo  Name(Model)   : %WT_SYSTEM%
REM echo.

REM ====================================================================================================

echo =====================================================================================
echo  Hardware(s)     Information
echo =====================================================================================
REM ====================================================================================================
REM echo Detecting Monitor...
for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetMonitorInfo.ps1"
') do (
    set "%%A=%%B"
)
echo  Monitor       : %WT_MONITOR%
REM ====================================================================================================
:: CPU
REM echo Detecting CPU...
for /f "skip=1 delims=" %%i in ('wmic cpu get Name') do (
    if not "%%i"=="" (
        set "WT_CPU=%%i"
        goto :CPUDone
    )
)
:CPUDone
echo  CPU           : %WT_CPU%
REM ====================================================================================================
:: RAM
REM call :Spin

REM echo Detecting Memory...
for /f "delims=" %%i in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetMemoryInfo.ps1"
') do (
    set "WT_RAMINFO=%%i"
)
echo  RAM           : %WT_RAMINFO%
REM ====================================================================================================


set "WT_GPU="

for /f "skip=1 tokens=* delims=" %%i in ('wmic path Win32_VideoController get Name ^| findstr /r /v "^$"') do (
    if defined WT_GPU (
        set "WT_GPU=!WT_GPU! + %%i"
    ) else (
        set "WT_GPU=%%i"
    )
)
:GPUDone
echo  Graphics      : %WT_GPU%

REM ====================================================================================================
:: Storage
REM echo Detecting Storage Devices...
for /f "delims=" %%i in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetStorageInfo.ps1"
') do (
    set "WT_STORAGE=%%i"
)
echo  Storage       : %WT_STORAGE%
echo.
REM ====================================================================================================
REM echo Detecting Motherboard...
:: Motherboard
for /f "skip=1 delims=" %%i in ('wmic baseboard get Product') do (
    if not "%%i"=="" (
        set "WT_BOARD=%%i"
        goto :BoardDone
    )
)
:BoardDone
echo  Motherboard   : %WT_BOARD%
REM ====================================================================================================
:: BIOS
REM echo Detecting BIOS...
for /f "skip=1 delims=" %%i in ('wmic bios get SMBIOSBIOSVersion') do (
    if not "%%i"=="" (
        set "WT_BIOS=%%i"
        goto :BIOSDone
    )
)
:BIOSDone
echo  BIOS          : %WT_BIOS%
REM ====================================================================================================
:: Boot Mode
for /f "delims=" %%A in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetBootMode.ps1"
') do (
    set "WT_BOOTMODE=%%A"
)
echo  Boot Mode     : %WT_BOOTMODE%
REM ====================================================================================================
:: Secure Boot
REM echo Detecting Secure Boot Status...
for /f "delims=" %%A in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetSecureBoot.ps1"
') do (
    set "WT_SECUREBOOT=%%A"
)
echo  Secure Boot   : %WT_SECUREBOOT%
REM ====================================================================================================
:: TPM
REM echo Detecting TPM Status...
for /f "delims=" %%A in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetTPM.ps1"
') do (
    set "WT_TPM=%%A"
)
echo  TPM           : %WT_TPM%
echo.
REM ====================================================================================================
REM echo Detecting Input Devices...
for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetInputInfo.ps1"
') do (
    set "%%A=%%B"
)
if defined WT_INPUT echo  Input         : %WT_INPUT%
REM ====================================================================================================
REM echo Detecting Network Adapters...

for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetNetworkCardInfo.ps1"
') do (
    set "%%A=%%B"
)

REM ====================================================================================================

REM echo Detecting Network Speed...

for /f "tokens=1,* delims==" %%A in ('
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetNetworkInfo.ps1"
') do (
    set "%%A=%%B"
)
echo  Net adapter(s): %WT_NETWORK%
REM echo  TPM           : %WT_TPM%


REM ====================================================================================================
REM echo Detecting Battery...
for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetBatteryInfo.ps1"
') do (
    set "%%A=%%B"
)
echo  Battery       : %WT_BATTERY%

REM ====================================================================================================
:: Uptime
REM echo Detecting System Uptime...
echo =====================================================================================
echo  Software(s)     Information
echo =====================================================================================
 REM ==================================================================================================== 
for /f "tokens=1,* delims==" %%A in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetOSInfo.ps1"
') do (
    set "%%A=%%B"
)
 REM ==================================================================================================== 
:: Windows Activation
REM echo Detecting Windows Activation...
for /f "delims=" %%A in ('
 start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetWindowsActivation.ps1"
 ') do (
     set "WT_ACTIVATION=%%A"
  )
  
 echo  OS            : %WT_OS% (%WT_ACTIVATION%)
REM ==================================================================================================== 
echo  Computer Name : %WT_PC%
echo  User          : %WT_USER%
echo  Administrator : %WT_ADMIN%
REM ==================================================================================================== 

for /f "tokens=1,* delims==" %%A in ('
powershell -ExecutionPolicy Bypass -File "%~dp0Hardware\GetDomainINfo.ps1"
') do (
    set "%%A=%%B"
)  
  
if defined WT_NETWORKDomain echo  Net/Domain    : %WT_NETWORKDomain%
REM ====================================================================================================
REM echo Detecting Windows...

  REM echo Detecting Windows Features...

for /f "tokens=1,* delims==" %%A in ('
powershell -ExecutionPolicy Bypass -File "%~dp0Hardware\GetWindowsFeatures.ps1"
') do (
    if /I "%%A"=="WT_FEATURES" set "WT_FEATURES=%%B"
)
set "WT_OSFEATURES="

if defined WT_HIBERNATE (
    set "WT_OSFEATURES=Hibernate %WT_HIBERNATE%"
)

if defined WT_FASTSTARTUP (
    if defined WT_OSFEATURES (
        set "WT_OSFEATURES=!WT_OSFEATURES! / Fast Startup %WT_FASTSTARTUP%"
    ) else (
        set "WT_OSFEATURES=Fast Startup %WT_FASTSTARTUP%"
    )
)

if defined WT_FEATURES (
    if defined WT_OSFEATURES (
        set "WT_OSFEATURES=!WT_OSFEATURES! / %WT_FEATURES%"
    ) else (
        set "WT_OSFEATURES=%WT_FEATURES%"
    )
)

if defined WT_OSFEATURES  echo  OS Features   : !WT_OSFEATURES!
REM ====================================================================================================

REM echo Detecting Power Settings...

for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetPowerSettings.ps1"
') do (
    set "%%A=%%B"
)
if defined WT_POWERPLAN    echo  Power Plan    : %WT_POWERPLAN%

REM ====================================================================================================

for /f "delims=" %%A in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetUptime.ps1"
') do (
    set "WT_UPTIME=%%A"
)
echo  Uptime        : %WT_UPTIME%
echo.
echo  IPv4          : %WT_IPV4%
echo.
REM ====================================================================================================

REM echo Detecting Microsoft Office...
for /f "tokens=1,* delims==" %%A in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetOfficeInfo.ps1"
') do (
    set "%%A=%%B"
)
REM ====================================================================================================
 :: Office Activation
REM echo Detecting Office Activation...
for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetOfficeActivated.ps1"
') do (
    set "%%A=%%B"
)
echo  Office        : %WT_OFFICE% (%WT_OFFICE_ACTIVATED%)
echo.




REM ====================================================================================================
REM echo Detecting Installed Antivirus(es)...

for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetAntivirus.ps1"
') do (
    set "%%A=%%B"
)
echo  Security      : %WT_ANTIVIRUS% 
REM ====================================================================================================
REM echo Detecting Firewall Status...
for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetFirewall.ps1"
') do (
    set "%%A=%%B"
)
echo  Firewall      : %WT_FIREWALL%
echo.
REM ====================================================================================================
REM echo Detecting Installed Browser(s)...
for /f "tokens=1,* delims==" %%A in ('
start "" /b /wait powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetBrowserInfo.ps1"
') do (
    set "%%A=%%B"
)
echo  Browsers(s)   : %WT_BROWSERS%
REM ====================================================================================================
REM echo Detecting PDF Reader(s)...

for /f "tokens=1,* delims==" %%A in ('
powershell -ExecutionPolicy Bypass -File "%~dp0Hardware\GetPdfInfo.ps1"
') do (
    if /I "%%A"=="WT_PDF" set "WT_PDF=%%B"
)
echo  PDF           : %WT_PDF%
REM ====================================================================================================
REM echo Detecting Media Playes(s)...

for /f "tokens=1,* delims==" %%A in ('
powershell -ExecutionPolicy Bypass -File "%~dp0Hardware\GetPlayerInfo.ps1"
') do (
    if /I "%%A"=="WT_MEDIA" set "WT_MEDIA=%%B"
)
echo  Media         : %WT_MEDIA%
REM ====================================================================================================
REM echo Detecting Compression Software(s)...
for /f "tokens=1,* delims==" %%A in ('
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Hardware\GetCompression.ps1"
') do (
    set "%%A=%%B"
)
echo  Archive       : %WT_COMPRESS%

echo =====================================================================================
REM =========================================================================================

REM cls
REM ====================================================================================================
REM call "%~dp0..\Assets\Config.bat"
REM call "%~dp0..\Assets\Header.bat"



pause


exit /b

