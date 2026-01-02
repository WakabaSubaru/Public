# Import the Active Directory module
Import-Module ActiveDirectory

# Get the directory of the CMD script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$resultDir = Join-Path -Path $scriptDir -ChildPath "result"

# Define the domain names you want to search in
$domainNames = @("us.com", "ap.com", "eu.com")

# Function to get user details from a domain
function Get-UserDetails($email, $domainNames) {
    foreach ($domainName in $domainNames) {
        Write-Host "Searching in domain: $domainName"
        $user = Get-ADUser -Server $domainName -Filter {EmailAddress -eq $email} -Properties Name, SamAccountName, EmailAddress, Department, Title, MemberOf
        if ($user) {
            Write-Host "User found in $domainName"
            return $user
        } else {
        Write-Host "User not found in $domainName"
        }
    }
    return $null
}

# Function to log user details and groups
function Log-UserDetails($user, $resultDir) {
    $outputFile = Join-Path -Path $resultDir -ChildPath "$($user.Name).txt"
    if (-not (Test-Path -Path $resultDir)) {
        New-Item -Path $resultDir -ItemType Directory
        }
    Clear-Content -Path $outputFile
    $user | Select-Object Name, SamAccountName, EmailAddress, Department, Title, MemberOf | Out-File -FilePath $outputFile -Append

    $groupNames = @()
    foreach ($group in $user.MemberOf) {
 try {
 $groupName = (Get-ADGroup -Identity $group).Name
 $groupNames += $groupName
 Write-Host "Group found: $groupName"
 } catch {
 if ($group -match "CN=([^,]+)") {
 $cn = $matches[1]
 Write-Host "Error querying group $cn in domain $domainName"
 $groupNames += $cn
 }
 }
 }
 $sortedGroupNames = $groupNames | Sort-Object
 $sortedGroupNames | Out-File -FilePath $outputFile -Append
 Write-Host "User details and group memberships have been logged to $outputFile"
 return $sortedGroupNames
}

# Function to add groups to target user
function Add-GroupsToUser($targetEmail, $sortedGroupNames, $domainNames) {
 foreach ($domainName in $domainNames) {
 Write-Host "Searching for target user in domain: $domainName"
 $targetUser = Get-ADUser -Server $domainName -Filter {EmailAddress -eq $targetEmail} -Properties SamAccountName
 if ($targetUser) {
 Write-Host "Target user found in $domainName"
 foreach ($groupName in $sortedGroupNames) {
 try {
 # Check if the target user is already a member of the group
 $groupMembers = Get-ADGroupMember -Identity $groupName
 $isMember = $groupMembers | Where-Object { $_.SamAccountName -eq $targetUser.SamAccountName }
 
 if (-not $isMember) {
 # Add the target user to the group
 Add-ADGroupMember -Identity $groupName -Members $targetUser.SamAccountName
 Write-Host "Added $targetUser.SamAccountName to group $groupName"
 } else {
 Write-Host "$targetUser.SamAccountName is already a member of $groupName"
 }
 } catch {
 Write-Host "Error adding $targetUser.SamAccountName to group $groupName"
 }
 }
 return $true
 } else {
 Write-Host "Target user not found in $domainName"
 }
 }
 return $false
}

while ($true) {
 try {
 # Prompt the user to enter the email of the user to search for
 $email = Read-Host -Prompt "Enter User Email Address to find the user and their groups."
 # Search for the user and get their details
 $user = Get-UserDetails $email $domainNames
 if ($user) {
 # Log user details and get their group memberships
 $sortedGroupNames = Log-UserDetails $user $resultDir
 # Prompt for the target user to add groups to
 $targetEmail = Read-Host -Prompt "Enter the email address of the target user to add these groups to."
 # Attempt to add the groups to the target user
 $targetUserFound = Add-GroupsToUser $targetEmail $sortedGroupNames $domainNames
 if (-not $targetUserFound) {
 Write-Host "No target user found with the email address $targetEmail"
 }
 } else {
 Write-Host "No user found with the email address $email"
 }
 Write-Host "Press Ctrl+C to exit the script or wait to search for another user."
 Start-Sleep -Seconds 5 # Wait for 5 seconds before the next iteration
 } catch {
 Write-Host "Script interrupted. Exiting..."
 break
 }
}
