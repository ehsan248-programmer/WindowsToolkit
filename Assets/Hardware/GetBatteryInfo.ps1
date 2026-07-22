function Out-Var {
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

#--------------------------------------------------
# Battery Exists?
#--------------------------------------------------
$Battery = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue

if (-not $Battery)
{
    Out-Var WT_BATTERY "No Battery"
    exit
}

#--------------------------------------------------
# Design & Full Charge Capacity
#--------------------------------------------------
$Design = Get-CimInstance -Namespace root\wmi `
-Class BatteryStaticData -ErrorAction SilentlyContinue

$Full = Get-CimInstance -Namespace root\wmi `
-Class BatteryFullChargedCapacity -ErrorAction SilentlyContinue

if($Design -and $Full)
{
    $Health = [math]::Round(($Full.FullChargedCapacity / $Design.DesignedCapacity) * 100)

    switch ($Battery.BatteryStatus)
    {
        1 {$State="Discharging"}
        2 {$State="AC"}
        3 {$State="Fully Charged"}
        4 {$State="Low"}
        5 {$State="Critical"}
        6 {$State="Charging"}
        7 {$State="Charging"}
        8 {$State="Charging"}
        9 {$State="Charging"}
        Default {$State="Unknown"}
    }

    if($Health -ge 90)
    {
        $Quality="Excellent"
    }
    elseif($Health -ge 80)
    {
        $Quality="Good"
    }
    elseif($Health -ge 70)
    {
        $Quality="Fair"
    }
    else
    {
        $Quality="Poor"
    }

    Out-Var WT_BATTERY "$Health%% Health ($Quality) | $State"
}
else
{
    Out-Var WT_BATTERY "Detected"
}