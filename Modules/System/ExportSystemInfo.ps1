# ==============================
# Windows Toolkit 2.0
# Export System Information
# Compatible: Windows 7 - Windows 11
# ==============================

$ReportFolder = Join-Path $PSScriptRoot "..\..\Reports"

if (!(Test-Path $ReportFolder)) {
    New-Item -ItemType Directory -Path $ReportFolder | Out-Null
}

$Report = Join-Path $ReportFolder "SystemInfo.txt"

#-------------------------------
# Get-WTObject (CIM if available, otherwise WMI)
#-------------------------------
function Get-WTObject($Class)
{
    if (Get-Command Get-CimInstance -ErrorAction SilentlyContinue)
    {
        return Get-CimInstance $Class
    }
    else
    {
        return Get-WmiObject $Class
    }
}

$OS    = Get-WTObject Win32_OperatingSystem
$CPU   = Get-WTObject Win32_Processor | Select-Object -First 1
$CS    = Get-WTObject Win32_ComputerSystem
$GPU   = Get-WTObject Win32_VideoController | Select-Object -First 1
$Board = Get-WTObject Win32_BaseBoard
$BIOS  = Get-WTObject Win32_BIOS
$Disk  = Get-WTObject Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}

$RAMGB = [Math]::Round($CS.TotalPhysicalMemory / 1GB,2)

$Out = @()

$Out += "============================================================"
$Out += "Windows Toolkit 2.0"
$Out += "System Information Report"
$Out += "============================================================"
$Out += ""
$Out += "Date            : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$Out += "Computer Name   : $env:COMPUTERNAME"
$Out += "User            : $env:USERNAME"
$Out += ""

#------------------------------------------------------------
$Out += "================ Windows ================="

$Out += "OS              : $($OS.Caption)"
$Out += "Version         : $($OS.Version)"
$Out += "Build           : $($OS.BuildNumber)"
$Out += "Architecture    : $($OS.OSArchitecture)"

try {
    $Release = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion
    if(!$Release)
    {
        $Release = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
    }

    if($Release)
    {
        $Out += "Release         : $Release"
    }
}
catch{}

$Out += ""

#------------------------------------------------------------
$Out += "================ Hardware ================="

$Out += "CPU             : $($CPU.Name)"
$Out += "RAM             : $RAMGB GB"

$Out += "Motherboard     : $($Board.Manufacturer) $($Board.Product)"

$Out += "BIOS            : $($BIOS.Manufacturer) $($BIOS.SMBIOSBIOSVersion)"

$Out += "Graphics        : $($GPU.Name)"

$Out += ""

#------------------------------------------------------------
$Out += "================ Drives ================="

foreach($d in $Disk)
{
    $Free=[Math]::Round($d.FreeSpace/1GB,2)
    $Size=[Math]::Round($d.Size/1GB,2)

    $Out += "$($d.DeviceID)"
    $Out += "    FileSystem : $($d.FileSystem)"
    $Out += "    Free Space : $Free GB"
    $Out += "    Total Size : $Size GB"
    $Out += ""
}

#------------------------------------------------------------
$Out += "================ Network ================="

$Adapters = Get-WTObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled}

foreach($a in $Adapters)
{
    if($a.IPAddress)
    {
        foreach($ip in $a.IPAddress)
        {
            if($ip -notmatch ":")
            {
                $Out += "IPv4            : $ip"
            }
        }
    }

    if($a.MACAddress)
    {
        $Out += "MAC             : $($a.MACAddress)"
    }

    $Out += ""
}

#------------------------------------------------------------
$Out += "================ Windows Activation ================="

$Activation = cscript //nologo "$env:windir\System32\slmgr.vbs" /xpr

foreach($Line in $Activation)
{
    $Out += $Line
}

$Out += ""

#------------------------------------------------------------
$Out += "================ PowerShell ================="

$Out += "Version         : $($PSVersionTable.PSVersion)"

$Out += ""
$Out += "============================================================"

$Out | Out-File $Report -Encoding UTF8

Clear-Host

Write-Host
Write-Host "System report created successfully." -ForegroundColor Green
Write-Host

Get-Content $Report

Write-Host
Write-Host "Saved to:"
Write-Host $Report -ForegroundColor Yellow
Write-Host
Start-Process notepad.exe $Report