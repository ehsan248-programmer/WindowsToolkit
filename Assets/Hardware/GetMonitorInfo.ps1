function Out-Var {
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

#=========================
# Monitor Name & Size
#=========================
$Monitor = Get-CimInstance -Namespace root\wmi -Class WmiMonitorID -ErrorAction SilentlyContinue | Select-Object -First 1

$Model = "Unknown"
$Size = ""

if($Monitor)
{
    $Model = ($Monitor.UserFriendlyName |
        Where-Object {$_ -ne 0} |
        ForEach-Object {[char]$_}) -join ""

    $W = $Monitor.MaxHorizontalImageSize
    $H = $Monitor.MaxVerticalImageSize

    if($W -gt 0 -and $H -gt 0)
    {
        $Inch = [math]::Round([math]::Sqrt(($W*$W)+($H*$H))/2.54)
        $Size = "$Inch`""
    }
}

#=========================
# Resolution & Refresh Rate
#=========================
$Video = Get-CimInstance Win32_VideoController | Select-Object -First 1

$ResX = $Video.CurrentHorizontalResolution
$ResY = $Video.CurrentVerticalResolution
$Refresh = $Video.CurrentRefreshRate

if($Refresh -gt 1)
{
    $Display = "$Model $Size ($ResX x $ResY @${Refresh}Hz)"
}
else
{
    $Display = "$Model $Size ($ResX x $ResY)"
}

Out-Var WT_MONITOR $Display