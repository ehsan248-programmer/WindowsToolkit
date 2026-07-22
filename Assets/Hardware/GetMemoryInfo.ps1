$mem = @(Get-WmiObject Win32_PhysicalMemory)

$total = [math]::Round((($mem | Measure-Object Capacity -Sum).Sum) / 1GB)
$count = $mem.Count

$type = switch ($mem[0].SMBIOSMemoryType) {
    20 {"DDR"}
    21 {"DDR2"}
    24 {"DDR3"}
    26 {"DDR4"}
    34 {"DDR5"}
    default {"Memory"}
}

# ظرفیت هر ماژول
$sizes = $mem | ForEach-Object { [math]::Round($_.Capacity / 1GB) }

# فقط یک ماژول
if ($count -eq 1) {
    "$total GB ($type)"
    exit
}

# همه ماژول‌ها هم‌اندازه هستند؟
$unique = $sizes | Select-Object -Unique

if ($unique.Count -eq 1) {
    "$total GB ($count x $($unique[0]) GB $type)"
}
else {
    $list = ($sizes | ForEach-Object { "$_ GB" }) -join " + "
    "$total GB ($list $type)"
}