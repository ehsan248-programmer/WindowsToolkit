function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

#-------------------------------------------------------
# Click-To-Run (Office 365 / 2019 / 2021 / 2024)
#-------------------------------------------------------

try
{
    $Cfg = Get-ItemProperty `
    "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" `
    -ErrorAction Stop

    if($Cfg.ProductReleaseIds)
    {
        $Name = $Cfg.ProductReleaseIds

        switch -Regex ($Name)
        {
            "2024"      {$Edition="Office 2024"}
            "2021"      {$Edition="Office 2021"}
            "2019"      {$Edition="Office 2019"}
            "O365|365"  {$Edition="Microsoft 365"}
            default     {$Edition="Microsoft Office"}
        }

        $Version = $Cfg.VersionToReport

        if($Version)
        {
            $Version = $Version -replace '(\.0)+$',''
            Out-Var WT_OFFICE "$Edition $Version"
        }
        else
        {
            Out-Var WT_OFFICE $Edition
        }

        exit
    }
}
catch{}

#-------------------------------------------------------
# Registry (Office 2010 / 2013 / 2016 MSI)
#-------------------------------------------------------

$Roots = @(
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
"HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
"HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
)

foreach($Root in $Roots)
{
    if(!(Test-Path $Root)){ continue }

    foreach($Key in Get-ChildItem $Root)
    {
        try
        {
            $App = Get-ItemProperty $Key.PSPath

            $Name = $App.DisplayName
            $Ver  = $App.DisplayVersion

            if([string]::IsNullOrWhiteSpace($Name))
            {
                continue
            }

            #---------------------------------------------
            # Ignore Office Runtime / VSTO
            #---------------------------------------------
            if($Name -match "Visual Studio|Office Runtime|Tools for Office|VSTO")
            {
                continue
            }

            #---------------------------------------------
            # Real Office Products
            #---------------------------------------------
            if($Name -match "Microsoft 365|Office")
            {
                if($Ver)
                {
                    $Short = $Ver -replace '(\.0)+$',''

                    if($Name -match [regex]::Escape($Short))
                    {
                        Out-Var WT_OFFICE $Name
                    }
                    else
                    {
                        Out-Var WT_OFFICE "$Name $Short"
                    }
                }
                else
                {
                    Out-Var WT_OFFICE $Name
                }

                exit
            }
        }
        catch{}
    }
}

Out-Var WT_OFFICE "Not Installed"