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

        if($Name -match "VLC|PotPlayer|Media Player Classic|MPC-HC|MPC-BE|KMPlayer|AIMP|foobar2000|Winamp")
        {
            # Short Name
            $Name = $Name -replace "^VLC media player","VLC"
            $Name = $Name -replace "^DAUM PotPlayer.*","PotPlayer"
            $Name = $Name -replace "^PotPlayer.*","PotPlayer"
            $Name = $Name -replace "^Media Player Classic - Home Cinema","MPC-HC"
            $Name = $Name -replace "^Media Player Classic Home Cinema","MPC-HC"
            $Name = $Name -replace "^MPC-HC.*","MPC-HC"
            $Name = $Name -replace "^MPC-BE.*","MPC-BE"
            $Name = $Name -replace "^The KMPlayer","KMPlayer"
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

if($Apps.Count)
{
    Out-Var WT_MEDIA ($Apps -join " / ")
}
else
{
    Out-Var WT_MEDIA "Not Installed"
}