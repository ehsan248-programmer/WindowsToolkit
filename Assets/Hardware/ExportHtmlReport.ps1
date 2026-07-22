# ============================================================
# Windows Toolkit
# Export HTML System Report
# Version 2.0
# ============================================================

$ReportDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$Desktop = [Environment]::GetFolderPath("Desktop")
$ReportFile = Join-Path $Desktop "WindowsToolkit_Report.html"

#----------------------------------------------------------
# Functions
#----------------------------------------------------------

function Get-RegValue
{
    param($Path,$Name)

    try
    {
        (Get-ItemProperty $Path -ErrorAction Stop).$Name
    }
    catch
    {
        ""
    }
}

function Get-ServiceState
{
    param($Service)

    try
    {
        (Get-Service $Service -ErrorAction Stop).Status
    }
    catch
    {
        "Unknown"
    }
}

function Get-Activation
{
    try
    {
        $Status=(Get-CimInstance SoftwareLicensingProduct |
        Where-Object {
            $_.PartialProductKey -and
            $_.LicenseStatus -eq 1
        }).Count

        if($Status -gt 0)
        {
            "Activated"
        }
        else
        {
            "Not Activated"
        }
    }
    catch
    {
        "Unknown"
    }
}

#----------------------------------------------------------
# Hardware
#----------------------------------------------------------

$CPU=(Get-CimInstance Win32_Processor).Name.Trim()

$RAM=[math]::Round(
(
(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory
/1GB
),0)

$GPU=(Get-CimInstance Win32_VideoController |
Select-Object -ExpandProperty Name) -join " + "

$MB=(Get-CimInstance Win32_BaseBoard).Product

$BIOS=(Get-CimInstance Win32_BIOS).SMBIOSBIOSVersion

$Monitor=(Get-CimInstance Win32_VideoController |
Select-Object -First 1 CurrentHorizontalResolution,
CurrentVerticalResolution)

$MonitorRes="$($Monitor.CurrentHorizontalResolution) × $($Monitor.CurrentVerticalResolution)"

$Storage=(Get-PhysicalDisk |
ForEach-Object{

$Size=[math]::Round($_.Size/1GB)

"$($_.FriendlyName) ($($_.MediaType), $Size GB)"

}) -join "<br>"

#----------------------------------------------------------
# Windows
#----------------------------------------------------------

$OS=Get-CimInstance Win32_OperatingSystem

$WindowsName=$OS.Caption

$WindowsVersion=$OS.Version

$Architecture=$OS.OSArchitecture

$InstallDate=$OS.InstallDate.Substring(0,8)

$Activation=Get-Activation

$RDP=if((Get-RegValue "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" "fDenyTSConnections") -eq 0){"On"}else{"Off"}

$Hibernate=if((powercfg /a) -match "Hibernate has not been enabled"){"Off"}else{"On"}

$FastStartup=if((Get-RegValue "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" "HiberbootEnabled") -eq 1){"On"}else{"Off"}

$Update=Get-ServiceState "wuauserv"


#----------------------------------------------------------
# Office
#----------------------------------------------------------

$Office = "Not Installed"

$OfficeKeys = @(
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
"HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

foreach($Root in $OfficeKeys)
{
    if(!(Test-Path $Root)){continue}

    Get-ItemProperty "$Root\*" -ErrorAction SilentlyContinue | ForEach-Object{

        if($_.DisplayName -match "Office|Microsoft 365")
        {
            if($_.DisplayName -match "Runtime|Visual Studio|Tools for Office|VSTO")
            {
                return
            }

            $Office = "$($_.DisplayName) $($_.DisplayVersion)"
            break
        }

    }

    if($Office -ne "Not Installed"){break}
}

#----------------------------------------------------------
# Browsers
#----------------------------------------------------------

$Browsers=@()

$BrowserPattern="Chrome|Firefox|Microsoft Edge|Opera|Brave"

$OfficeKeys | ForEach-Object{

    if(Test-Path $_)
    {

        Get-ItemProperty "$_\*" -ErrorAction SilentlyContinue | ForEach-Object{

            if($_.DisplayName -match $BrowserPattern)
            {

                $Browsers += "$($_.DisplayName) $($_.DisplayVersion)"

            }

        }

    }

}

$Browsers=($Browsers|Sort-Object -Unique) -join "<br>"

if(!$Browsers){$Browsers="Not Installed"}

#----------------------------------------------------------
# PDF
#----------------------------------------------------------

$PDF=@()

$PDFPattern="Adobe Acrobat|Adobe Reader|Foxit|PDF-XChange|SumatraPDF"

$OfficeKeys | ForEach-Object{

if(Test-Path $_){

Get-ItemProperty "$_\*" -ErrorAction SilentlyContinue | ForEach-Object{

if($_.DisplayName -match $PDFPattern){

$PDF+="$($_.DisplayName) $($_.DisplayVersion)"

}

}

}

}

$PDF=($PDF|Sort-Object -Unique)-join "<br>"

if(!$PDF){$PDF="Not Installed"}

#----------------------------------------------------------
# Multimedia
#----------------------------------------------------------

$Media=@()

$MediaPattern="VLC|PotPlayer|AIMP|foobar2000|Winamp|KMPlayer|MPC"

$OfficeKeys | ForEach-Object{

if(Test-Path $_){

Get-ItemProperty "$_\*" -ErrorAction SilentlyContinue | ForEach-Object{

if($_.DisplayName -match $MediaPattern){

$Media+="$($_.DisplayName) $($_.DisplayVersion)"

}

}

}

}

$Media=($Media|Sort-Object -Unique)-join "<br>"

if(!$Media){$Media="Not Installed"}

#----------------------------------------------------------
# Archive
#----------------------------------------------------------

$Archive=@()

$ArchivePattern="WinRAR|7-Zip|PeaZip|Bandizip"

$OfficeKeys | ForEach-Object{

if(Test-Path $_){

Get-ItemProperty "$_\*" -ErrorAction SilentlyContinue | ForEach-Object{

if($_.DisplayName -match $ArchivePattern){

$Archive+="$($_.DisplayName) $($_.DisplayVersion)"

}

}

}

}

$Archive=($Archive|Sort-Object -Unique)-join "<br>"

if(!$Archive){$Archive="Not Installed"}

#----------------------------------------------------------
# HTML
#----------------------------------------------------------

$HTML=@"

<!DOCTYPE html>

<html>

<head>

<meta charset="utf-8">

<title>Windows Toolkit Report</title>

<style>

body{

font-family:Segoe UI;

background:#f5f7fa;

margin:30px;

color:#333;

}

.card{

background:white;

border-radius:10px;

padding:20px;

margin-bottom:20px;

box-shadow:0 2px 10px rgba(0,0,0,.1);

}

h1{

color:#0078D7;

}

h2{

border-bottom:2px solid #0078D7;

padding-bottom:6px;

}

table{

width:100%;

border-collapse:collapse;

}

td{

padding:8px;

border-bottom:1px solid #eee;

vertical-align:top;

}

td:first-child{

width:230px;

font-weight:bold;

color:#0066AA;

}

.footer{

margin-top:40px;

text-align:center;

font-size:12px;

color:#888;

}

</style>

</head>

<body>

<div class="card">

<h1>Windows Toolkit</h1>

Generated : $ReportDate

</div>

"@
$HTML += @"

<div class="card">

<h2>Software Information</h2>

<table>

<tr><td>Operating System</td><td>$WindowsName</td></tr>

<tr><td>Version</td><td>$WindowsVersion</td></tr>

<tr><td>Architecture</td><td>$Architecture</td></tr>

<tr><td>Installed</td><td>$InstallDate</td></tr>

<tr><td>Activation</td><td>$Activation</td></tr>

<tr><td>Office</td><td>$Office</td></tr>

<tr><td>Browsers</td><td>$Browsers</td></tr>

<tr><td>PDF Software</td><td>$PDF</td></tr>

<tr><td>Media Software</td><td>$Media</td></tr>

<tr><td>Archive Software</td><td>$Archive</td></tr>

</table>

</div>

<div class="card">

<h2>Hardware Information</h2>

<table>

<tr><td>Processor</td><td>$CPU</td></tr>

<tr><td>Memory</td><td>$RAM GB</td></tr>

<tr><td>Graphics Adapter</td><td>$GPU</td></tr>

<tr><td>Storage</td><td>$Storage</td></tr>

<tr><td>Motherboard</td><td>$MB</td></tr>

<tr><td>BIOS</td><td>$BIOS</td></tr>

<tr><td>Monitor</td><td>$MonitorRes</td></tr>

</table>

</div>

<div class="card">

<h2>Windows Features</h2>

<table>

<tr><td>Remote Desktop</td><td>$RDP</td></tr>

<tr><td>Hibernate</td><td>$Hibernate</td></tr>

<tr><td>Fast Startup</td><td>$FastStartup</td></tr>

<tr><td>Windows Update</td><td>$Update</td></tr>

</table>

</div>

"@

#----------------------------------------------------------
# Network
#----------------------------------------------------------

try
{
    $Adapter = Get-NetAdapter |
        Where-Object Status -eq "Up" |
        Select-Object -First 1

    $IP = (Get-NetIPAddress -AddressFamily IPv4 |
        Where-Object InterfaceIndex -eq $Adapter.ifIndex |
        Select-Object -First 1).IPAddress
}
catch
{
    $Adapter = $null
    $IP = ""
}

$AdapterName = if($Adapter){$Adapter.Name}else{"Unknown"}
$IP = if($IP){$IP}else{"Unknown"}

$HTML += @"

<div class="card">

<h2>Network Information</h2>

<table>

<tr>
<td>Adapter</td>
<td>$AdapterName</td>
</tr>

<tr>
<td>IPv4 Address</td>
<td>$IP</td>
</tr>

</table>

</div>

<div class="footer">

Generated by <b>Windows Toolkit 2.0</b><br>

$ReportDate

</div>

</body>

</html>

"@

#----------------------------------------------------------
# Save Report
#----------------------------------------------------------

$HTML | Out-File `
-FilePath $ReportFile `
-Encoding UTF8

Start-Process $ReportFile