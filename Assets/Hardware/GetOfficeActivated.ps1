function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

$Paths=@(
"$env:ProgramFiles\Microsoft Office\Office16\OSPP.VBS",
"$env:ProgramFiles(x86)\Microsoft Office\Office16\OSPP.VBS",

"$env:ProgramFiles\Microsoft Office\Office15\OSPP.VBS",
"$env:ProgramFiles(x86)\Microsoft Office\Office15\OSPP.VBS",

"$env:ProgramFiles\Microsoft Office\Office14\OSPP.VBS",
"$env:ProgramFiles(x86)\Microsoft Office\Office14\OSPP.VBS"
)

foreach($OSPP in $Paths)
{
    if(Test-Path $OSPP)
    {
        $Result = cscript.exe //Nologo $OSPP /dstatus 2>$null

        if($Result -match "LICENSE STATUS:\s*---LICENSED---")
        {
            Out-Var WT_OFFICE_ACTIVATED "Activated"
            exit
        }

        if($Result -match "LICENSE STATUS")
        {
            Out-Var WT_OFFICE_ACTIVATED "Not Activated"
            exit
        }
    }
}

Out-Var WT_OFFICE_ACTIVATED "Unknown"