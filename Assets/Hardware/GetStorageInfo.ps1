function Format-DiskSize
{
    param([UInt64]$Size)

    $GB = [math]::Round($Size / 1GB)

    if($GB -ge 28  -and $GB -lt 35)   { return "32 GB" }
    if($GB -ge 55  -and $GB -lt 65)   { return "64 GB" }

    if($GB -ge 110 -and $GB -lt 118)  { return "120 GB" }
    if($GB -ge 118 -and $GB -lt 135)  { return "128 GB" }

    if($GB -ge 220 -and $GB -lt 235)  { return "240 GB" }
    if($GB -ge 235 -and $GB -lt 245)  { return "250 GB" }
    if($GB -ge 245 -and $GB -lt 270)  { return "256 GB" }

    if($GB -ge 445 -and $GB -lt 470)  { return "480 GB" }
    if($GB -ge 470 -and $GB -lt 520)  { return "512 GB" }

    if($GB -ge 890 -and $GB -lt 920)  { return "960 GB" }
    if($GB -ge 920 -and $GB -lt 1100) { return "1 TB" }

    if($GB -ge 1800 -and $GB -lt 2200){ return "2 TB" }
    if($GB -ge 3600 -and $GB -lt 4300){ return "4 TB" }
    if($GB -ge 7200 -and $GB -lt 8500){ return "8 TB" }

    if($GB -ge 1000)
    {
        return ("{0:N1} TB" -f ($Size / 1TB))
    }

    return "$GB GB"
}

$disks = Get-PhysicalDisk
$drives = Get-Disk

$result = @()

foreach($disk in $disks)
{
    $drive = $drives | Where-Object Number -eq $disk.DeviceId

    if($drive)
    {
        $cap = Format-DiskSize $drive.Size
    }
    else
    {
        $cap = "Unknown"
    }

    $result += "$($disk.MediaType) ($cap)"
}

$result -join " + "