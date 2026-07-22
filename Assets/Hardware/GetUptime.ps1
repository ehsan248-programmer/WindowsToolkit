$boot = ([Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject Win32_OperatingSystem).LastBootUpTime))
$span = (Get-Date) - $boot

if($span.Days -gt 0)
{
    "{0} Days {1} Hours" -f $span.Days,$span.Hours
}
elseif($span.Hours -gt 0)
{
    "{0} Hours {1} Minutes" -f $span.Hours,$span.Minutes
}
else
{
    "{0} Minutes" -f $span.Minutes
}