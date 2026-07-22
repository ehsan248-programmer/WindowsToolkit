function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

try
{
    # ابتدا فقط کارت‌های فیزیکی و فعال
    $Adapters = Get-WmiObject Win32_NetworkAdapter -ErrorAction Stop |
        Where-Object {
            $_.PhysicalAdapter -eq $true -and
            $_.NetEnabled -eq $true -and
            $_.Name
        }

    # اگر هیچ کارت فعالی نبود، کارت‌های فیزیکی را نمایش بده
    if(!$Adapters)
    {
        $Adapters = Get-WmiObject Win32_NetworkAdapter |
            Where-Object {
                $_.PhysicalAdapter -eq $true -and
                $_.Name
            }
    }

    $Names = @()

    foreach($A in $Adapters)
    {
        try
        {
            $Name = $A.Name.Trim()

            # حذف آداپتورهای مجازی
            if($Name -match "VMware|Hyper-V|Virtual|TAP|Bluetooth|Loopback|WAN Miniport")
            {
                continue
            }

            $Names += $Name
        }
        catch{}
    }

    if($Names.Count -eq 0)
    {
        Out-Var WT_NETWORK "Unknown"
    }
    else
    {
        Out-Var WT_NETWORK ($Names -join " + ")
    }
}
catch
{
    Out-Var WT_NETWORK "Unknown"
}