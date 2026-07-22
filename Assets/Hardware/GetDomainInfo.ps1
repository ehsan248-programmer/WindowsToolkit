function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

$cs = Get-CimInstance Win32_ComputerSystem

if($cs.PartOfDomain)
{
    Out-Var WT_NETWORKDomain "$($cs.Domain) (Domain)"
}
else
{
    Out-Var WT_NETWORKDomain "$($cs.Workgroup) (Workgroup)"
}