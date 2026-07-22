$lic = Get-WmiObject SoftwareLicensingProduct |
Where-Object {
    $_.PartialProductKey -and
    $_.Name -like "Windows*"
} |
Select-Object -First 1

if($lic.LicenseStatus -eq 1)
{
    "Activated"
}
else
{
    "Not Activated"
}