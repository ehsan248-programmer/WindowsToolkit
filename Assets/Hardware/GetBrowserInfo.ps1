# ============================================
# Windows Toolkit
# GetBrowserInfo.ps1
# ============================================

function Out-Var
{
    param($Name,$Value)

    if([string]::IsNullOrWhiteSpace($Value))
    {
        $Value = ""
    }

    Write-Output "$Name=$Value"
}

function Get-BrowserVersion
{
    param(
        [string[]]$RegPaths,
        [string[]]$ExePaths
    )

    foreach($Reg in $RegPaths)
    {
        try
        {
            $Exe = (Get-ItemProperty -Path $Reg -ErrorAction Stop).'(Default)'

            if(Test-Path $Exe)
            {
                return (Get-Item $Exe).VersionInfo.ProductVersion
            }
        }
        catch{}
    }

    foreach($Exe in $ExePaths)
    {
        if(Test-Path $Exe)
        {
            return (Get-Item $Exe).VersionInfo.ProductVersion
        }
    }

    return $null
}

# ---------------- Edge ----------------

$Edge = Get-BrowserVersion `
@(
'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe',
'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe'
) `
@(
"$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
"${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
)

# ---------------- Chrome ----------------

$Chrome = Get-BrowserVersion `
@(
'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe',
'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
) `
@(
"$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
"${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
)

# ---------------- Firefox ----------------

$Firefox = Get-BrowserVersion `
@(
'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe',
'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe'
) `
@(
"$env:ProgramFiles\Mozilla Firefox\firefox.exe",
"${env:ProgramFiles(x86)}\Mozilla Firefox\firefox.exe"
)

# ---------------- Brave ----------------

$Brave = Get-BrowserVersion `
@(
'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\brave.exe',
'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\brave.exe'
) `
@(
"$env:ProgramFiles\BraveSoftware\Brave-Browser\Application\brave.exe",
"${env:ProgramFiles(x86)}\BraveSoftware\Brave-Browser\Application\brave.exe"
)

# ---------------- Opera ----------------

$Opera = Get-BrowserVersion `
@(
'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\opera.exe',
'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\opera.exe'
) `
@(
"$env:LOCALAPPDATA\Programs\Opera\opera.exe",
"$env:ProgramFiles\Opera\opera.exe",
"${env:ProgramFiles(x86)}\Opera\opera.exe"
)

# ---------------- Build Output ----------------

$List = @()

if($Edge)
{
    $List += "Edge $($Edge.Split('.')[0])"
}

if($Chrome)
{
    $List += "Chrome $($Chrome.Split('.')[0])"
}

if($Firefox)
{
    $List += "Firefox $($Firefox.Split('.')[0])"
}

if($Brave)
{
    $List += "Brave $($Brave.Split('.')[0])"
}

if($Opera)
{
    $List += "Opera $($Opera.Split('.')[0])"
}
Out-Var WT_BROWSERS ($List -join "/ ")
# Out-Var WT_BROWSEسRS ($List -join " | ")