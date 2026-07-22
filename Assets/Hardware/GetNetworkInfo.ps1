function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

try
{
    $Cfg = Get-WmiObject Win32_NetworkAdapterConfiguration -ErrorAction Stop |
        Where-Object { $_.IPEnabled }

    if(!$Cfg)
    {
        Out-Var WT_IPV4 "Unknown"
        exit
    }

    $IPv4 = @()

    foreach($Item in $Cfg)
    {
        try
        {
            foreach($IP in $Item.IPAddress)
            {
                if($IP -match '^\d+\.\d+\.\d+\.\d+$')
                {
                    $IPv4 += $IP
                }
            }
        }
        catch{}
    }

    if($IPv4.Count)
    {
        Out-Var WT_IPV4 ($IPv4 -join " + ")
    }
    else
    {
        Out-Var WT_IPV4 "Unknown"
    }
}
catch
{
    Out-Var WT_IPV4 "Unknown"
}