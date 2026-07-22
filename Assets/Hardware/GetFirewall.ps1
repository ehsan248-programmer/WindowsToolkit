function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

try
{
    $Profiles = Get-NetFirewallProfile -ErrorAction Stop

    if($Profiles.Enabled -contains $false)
    {
        Out-Var WT_FIREWALL "Off"
    }
    else
    {
        Out-Var WT_FIREWALL "On"
    }
}
catch
{
    Out-Var WT_FIREWALL "Unknown"
}