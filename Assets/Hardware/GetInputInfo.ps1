function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

# اگر لپ‌تاپ باشد، چیزی نمایش نده
try
{
    $PC = Get-CimInstance Win32_ComputerSystem

    if($PC.PCSystemType -eq 2)
    {
        Out-Var WT_INPUT ""
        exit
    }
}
catch
{
}

# Keyboard
$KBType = "Unknown"

try
{
    $KB = Get-CimInstance Win32_Keyboard | Select-Object -First 1

    if($KB.PNPDeviceID)
    {
        if($KB.PNPDeviceID.StartsWith("USB"))
        {
            $KBType = "USB Keyboard"
        }
        else
        {
            $KBType = "PS/2 Keyboard"
        }
    }
}
catch
{
}

# Mouse
$MSType = "Unknown"

try
{
    $MS = Get-CimInstance Win32_PointingDevice | Select-Object -First 1

    if($MS.PNPDeviceID)
    {
        if($MS.PNPDeviceID.StartsWith("USB"))
        {
            $MSType = "USB Mouse"
        }
        else
        {
            $MSType = "PS/2 Mouse"
        }
    }
}
catch
{
}

Out-Var WT_INPUT "$KBType , $MSType"