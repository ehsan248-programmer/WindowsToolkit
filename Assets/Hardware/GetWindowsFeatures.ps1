function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

#-------------------------------------------------------
# Remote Desktop
#-------------------------------------------------------
$RDP = "Unknown"

try
{
    $v = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server").fDenyTSConnections

    if($v -eq 0)
    {
        $RDP = "On"
    }
    else
    {
        $RDP = "Off"
    }
}
catch
{
    $RDP = "Unknown"
}

#-------------------------------------------------------
# BitLocker
#-------------------------------------------------------
$BitLocker = "N/A"

try
{
    $MBDE = Get-Command manage-bde.exe -ErrorAction Stop

    $Status = manage-bde -status $env:SystemDrive 2>$null | Out-String

    if($Status -match "Protection On")
    {
        $BitLocker = "On"
    }
    elseif($Status -match "Protection Off")
    {
        $BitLocker = "Off"
    }
    elseif($Status -match "BitLocker")
    {
        $BitLocker = "Off"
    }
}
catch
{
    $BitLocker = "N/A"
}

#-------------------------------------------------------
# Windows Update
#-------------------------------------------------------
$Update = "Unknown"

try
{
    $svc = Get-Service wuauserv -ErrorAction Stop

    if($svc.Status -eq "Running")
    {
        $Update = "On"
    }
    else
    {
        $Update = "Off"
    }
}
catch
{
    $Update = "Unknown"
}

#-------------------------------------------------------
# Output
#-------------------------------------------------------

Out-Var WT_FEATURES "RDP $RDP / BitLocker $BitLocker / Update $Update"