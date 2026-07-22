try
{
    if (Get-Command Get-Tpm -ErrorAction SilentlyContinue)
    {
        $tpm = Get-Tpm

        if($tpm.TpmPresent)
        {
            if($tpm.TpmReady)
            {
                "Present"
            }
            else
            {
                "Present (Not Ready)"
            }
        }
        else
        {
            "Not Present"
        }
    }
    else
    {
        $tpm = Get-WmiObject -Namespace root\CIMV2\Security\MicrosoftTpm -Class Win32_Tpm -ErrorAction Stop

        if($tpm)
        {
            "Present"
        }
        else
        {
            "Not Present"
        }
    }
}
catch
{
    "Not Supported"
}