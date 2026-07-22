try
{
    if (Get-Command Confirm-SecureBootUEFI -ErrorAction SilentlyContinue)
    {
        if (Confirm-SecureBootUEFI)
        {
            "Enabled"
        }
        else
        {
            "Disabled"
        }
    }
    else
    {
        "Not Supported"
    }
}
catch
{
    "Not Supported"
}