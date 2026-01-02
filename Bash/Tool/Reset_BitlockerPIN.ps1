# Generate PIN from computer name (digits only)
$BitlockerPIN = ($env:computername -replace "\D", "")
if ([string]::IsNullOrEmpty($BitlockerPIN)) {
    Write-Error "No digits found in computer name. Cannot generate PIN."
    exit
}

# Reverse the PIN
$BitlockerPIN = -join ($BitlockerPIN[-1..-$BitlockerPIN.Length])

# Display the PIN and ask for user confirmation
Write-Host "The BitLocker PIN to be set is: $BitlockerPIN" -ForegroundColor Yellow
$confirmation = Read-Host "Do you want to proceed? Enter "Y" to continue, any other key to cancel."

if ($confirmation -ne "Y" -and $confirmation -ne "y") {
    Write-Host "Operation cancelled." -ForegroundColor Red
    exit
}

# Convert PIN to SecureString
$EDigi = ConvertTo-SecureString $BitlockerPIN -AsPlainText -Force

# Delete existing TPM+PIN protector
try {
    manage-bde -protectors c: -delete -type TPMAndPIN
    Write-Host "Existing TPM+PIN protector deleted." -ForegroundColor Green
} catch {
    Write-Warning "Failed to delete TPMAndPIN protector. It may not exist."
}

# Add new TPM+PIN protector
Add-BitLockerKeyProtector -MountPoint "C:" -Pin $EDigi -TPMandPinProtector
Write-Host "BitLocker TPM+PIN protector has been successfully updated." -ForegroundColor Green