# ===========================
# Windows Toolkit
# GetOSInfo.ps1
# ===========================

function Out-Var($Name,$Value)
{
    Write-Output "$Name=$Value"
}

$os = Get-WmiObject Win32_OperatingSystem
$cv = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

# Windows Name
$caption = $os.Caption.Trim().Replace("Microsoft ","")

# Version
$displayVersion = $cv.DisplayVersion

if([string]::IsNullOrWhiteSpace($displayVersion))
{
    $displayVersion = $cv.ReleaseId
}

# Build
$build = $cv.CurrentBuild

# Architecture
$arch = switch($os.OSArchitecture)
{
    "64-bit" { "x64" }
    "32-bit" { "x86" }
    default  { $os.OSArchitecture }
}

# Install Date
$installDate = [Management.ManagementDateTimeConverter]::ToDateTime($os.InstallDate)

# System Age
$days = ((Get-Date) - $installDate).Days

$years = [math]::Floor($days / 365)
$months = [math]::Floor(($days % 365) / 30)

if($years -gt 0)
{
    if($months -gt 0)
    {
        $age = "$years Years $months Months"
    }
    else
    {
        $age = "$years Years"
    }
}
else
{
    if($months -gt 0)
    {
        $age = "$months Months"
    }
    else
    {
        $age = "$days Days"
    }
}

Out-Var "WT_OS" "$caption $displayVersion $arch (Build $build)"
Out-Var "WT_INSTALLDATE" ($installDate.ToString("yyyy-MM-dd"))
Out-Var "WT_SYSTEMAGE" $age