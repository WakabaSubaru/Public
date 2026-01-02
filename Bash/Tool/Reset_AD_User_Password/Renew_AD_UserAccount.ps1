# Import the Active Directory module
Import-Module ActiveDirectory

function Show-Menu {
    param (
        [string]$prompt = 'Please choose an option'
    )
    Write-Host "1. Change domain user password"
    Write-Host "2. Unlock domain user account"
    Write-Host "3. Change password and unlock account"
    Write-Host "4. Exit"
    $choice = Read-Host $prompt
    return $choice
}

function Get-User {
    param (
        [string]$email
    )
    foreach ($domain in $domainNames) {
        $user = Get-ADUser -Filter { EmailAddress -eq $email } -Server $domain
        if ($user) {
            return $user, $domain
        }
    }
    return $null, $null
}

function Change-Password {
    $currentUserEmail = Read-Host "Please enter the current user's email address"
    $newPassword = Read-Host "Please enter the new password" -AsSecureString
    $user, $domain = Get-User -email $currentUserEmail
    if ($user) {
        Set-ADAccountPassword -Identity $user -NewPassword $newPassword -Reset
        Write-Host "The password for domain user with email $currentUserEmail in domain $domain has been changed."
    } else {
        Write-Host "User with email $currentUserEmail not found in any specified domain."
    }
}

function Unlock-Account {
    $currentUserEmail = Read-Host "Please enter the current user's email address"
    $user, $domain = Get-User -email $currentUserEmail
    if ($user) {
        Unlock-ADAccount -Identity $user
        Write-Host "The account for domain user with email $currentUserEmail in domain $domain has been unlocked."
    } else {
        Write-Host "User with email $currentUserEmail not found in any specified domain."
    }
}

function Change-Password-And-Unlock {
    $currentUserEmail = Read-Host "Please enter the current user's email address"
    $newPassword = Read-Host "Please enter the new password" -AsSecureString
    $user, $domain = Get-User -email $currentUserEmail
    if ($user) {
        Set-ADAccountPassword -Identity $user -NewPassword $newPassword -Reset
        Set-ADUser -Identity $user -ChangePasswordAtLogon $true
        Unlock-ADAccount -Identity $user
        Write-Host "The password for domain user with email $currentUserEmail in domain $domain has been changed and the account has been unlocked."
    } else {
        Write-Host "User with email $currentUserEmail not found in any specified domain."
    }
}

# List of domain names
$domainNames = @("sg.com", "us.com", "eu.com")

do {
    $choice = Show-Menu
    switch ($choice) {
        default { Write-Host "Invalid choice. Please try again." }
        1 { Change-Password }
        2 { Unlock-Account }
        3 { Change-Password-And-Unlock }
        4 { Write-Host "Exiting..."; break }
    }
} while ($choice -ne 4)
