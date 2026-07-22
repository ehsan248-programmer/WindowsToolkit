function Out-Var {
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

$Programs = @(
    "WinRAR",
    "7-Zip",
    "WinZip",
    "Bandizip",
    "PeaZip"
)

$Roots = @(
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
"HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
"HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
)

$List=@()

foreach($Root in $Roots)
{
    if(Test-Path $Root)
    {
        Get-ChildItem $Root | ForEach-Object{

            try{
                $App=Get-ItemProperty $_.PSPath

                foreach($P in $Programs)
                {
                    if($App.DisplayName -like "*$P*")
                    {
                        $Name = $App.DisplayName
						$Version = $App.DisplayVersion

						# حذف .0 های انتهایی
						$ShortVersion = $Version -replace '(\.0)+$',''

						if($Name -match [regex]::Escape($ShortVersion))
						{
							$List += $Name
						}
						else
						{
							$List += "$Name $Version"
						}
                    }
                }

            }catch{}
        }
    }
}

$List=$List | Sort-Object -Unique

if($List.Count)
{
    Out-Var WT_COMPRESS ($List -join " / ")
}
else
{
    Out-Var WT_COMPRESS "Not Installed"
}