try {
    $fw = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control" -ErrorAction Stop).PEFirmwareType

    switch ($fw) {
        1 { "Legacy BIOS"; exit }
        2 { "UEFI"; exit }
    }
}
catch {}

# روش دوم (سازگار با ویندوزهای قدیمی)

try {
    Confirm-SecureBootUEFI -ErrorAction Stop | Out-Null
    "UEFI"
}
catch {
    "Legacy BIOS"
}