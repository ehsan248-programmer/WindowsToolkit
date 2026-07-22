function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

$Roots = @(
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
"HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
"HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
)

$Apps = @()

foreach($Root in $Roots)
{
    if(!(Test-Path $Root)){ continue }

    Get-ItemProperty "$Root\*" -ErrorAction SilentlyContinue | ForEach-Object {

        $Name = $_.DisplayName
        $Ver  = $_.DisplayVersion

        if([string]::IsNullOrWhiteSpace($Name)){ return }

        if($Name -match "Adobe Acrobat|Adobe Reader|Acrobat Reader|Foxit|PDF-XChange|SumatraPDF")
        {
            # نام کوتاه
            $Name = $Name -replace "^Foxit Advanced PDF Editor.*","Foxit Editor"
            $Name = $Name -replace "^Foxit PDF Reader.*","Foxit Reader"
            $Name = $Name -replace "^PDF-XChange Editor.*","PDF-XChange"
            $Name = $Name -replace "^Adobe Acrobat Reader.*","Adobe Reader"
            $Name = $Name -replace "^Adobe Acrobat Pro.*","Adobe Acrobat"
            $Name = $Name.Trim()

            if($Ver)
            {
                $Apps += "$Name $Ver"
            }
            else
            {
                $Apps += $Name
            }
        }
    }
}

$Apps = $Apps | Sort-Object -Unique

if($Apps.Count -gt 0)
{
    Out-Var WT_PDF ($Apps -join " / ")
}
else
{
    Out-Var WT_PDF "Not Installed"
}