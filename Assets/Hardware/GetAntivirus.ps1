function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

try
{
    $AVs = Get-CimInstance -Namespace root/SecurityCenter2 -Class AntiVirusProduct -ErrorAction Stop

    if(-not $AVs)
    {
        Out-Var WT_ANTIVIRUS "Not Installed"
        exit
    }

    $Result = @()

    foreach($AV in $AVs)
    {
        $State = [int]$AV.productState

        # بیت 0x1000 نشان‌دهنده فعال بودن محصول است
        if(($State -band 0x1000) -ne 0)
        {
            $Mode = "Active"
        }
        else
        {
            $Mode = "Passive"
        }

        $Result += "$($AV.displayName) ($Mode)"
    }

    Out-Var WT_ANTIVIRUS ($Result -join " / ")
}
catch
{
    Out-Var WT_ANTIVIRUS "Unknown"
}