function Out-Var
{
    param($Name,$Value)
    Write-Output "$Name=$Value"
}

#---------------------------------------
# Power Plan
#---------------------------------------

try
{
    $Plan = (powercfg /GETACTIVESCHEME)

    if($Plan -match '\((.*?)\)')
    {
        Out-Var WT_POWERPLAN $Matches[1]
    }
    else
    {
        Out-Var WT_POWERPLAN "-"
    }
}
catch
{
    Out-Var WT_POWERPLAN "-"
}

#---------------------------------------
# Hibernate
#---------------------------------------

try
{
    $Hibernate = Get-ItemProperty `
        "HKLM:\SYSTEM\CurrentControlSet\Control\Power" `
        -Name HibernateEnabled `
        -ErrorAction Stop

    if($Hibernate.HibernateEnabled -eq 1)
    {
        Out-Var WT_HIBERNATE "On"
    }
    else
    {
        Out-Var WT_HIBERNATE "Off"
    }
}
catch
{
    Out-Var WT_HIBERNATE "-"
}

#---------------------------------------
# Fast Startup
#---------------------------------------

try
{
    $Fast = Get-ItemProperty `
        "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" `
        -Name HiberbootEnabled `
        -ErrorAction Stop

    if($Fast.HiberbootEnabled -eq 1)
    {
        Out-Var WT_FASTSTARTUP "On"
    }
    else
    {
        Out-Var WT_FASTSTARTUP "Off"
    }
}
catch
{
    Out-Var WT_FASTSTARTUP "-"
}