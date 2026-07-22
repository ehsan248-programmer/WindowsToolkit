# ============================================
# Windows Toolkit
# GetSystemInfo.ps1
# ============================================

function Out-Var
{
    param(
        [string]$Name,
        [string]$Value
    )

    if([string]::IsNullOrWhiteSpace($Value))
    {
        $Value = "Unknown"
    }

    Write-Output "$Name=$Value"
}

$cs = Get-CimInstance Win32_ComputerSystem

$Manufacturer = $cs.Manufacturer.Trim()
$Model = $cs.Model.Trim()

# اصلاح نام برخی برندها
switch -Regex ($Manufacturer)
{
    "^ASUSTeK"         { $Manufacturer = "ASUS" }
    "^Hewlett-Packard" { $Manufacturer = "HP" }
    "^Micro-Star"      { $Manufacturer = "MSI" }
    "^LENOVO"          { $Manufacturer = "Lenovo" }
}

# حذف مدل‌های نامعتبر
if($Model -in @(
    "System Product Name",
    "To Be Filled By O.E.M.",
    "Default string",
    "All Series"
))
{
    $Model = ""
}

# جلوگیری از تکرار نام سازنده
if($Model -and $Model.ToUpper().StartsWith($Manufacturer.ToUpper()))
{
    $System = $Model
}
elseif($Model)
{
    $System = "$Manufacturer $Model"
}
else
{
    $System = $Manufacturer
}

Out-Var WT_SYSTEM $System