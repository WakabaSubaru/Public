# Import the Active Directory module
Import-Module ActiveDirectory

# Get the directory of the CMD script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$resultDir = Join-Path -Path $scriptDir -ChildPath "result"

# Define the domain names you want to search in
$domainNames = @("asm.com", "sg.asm.com", "us.asm.com", "ap.asm.com", "eu.asm.com")

# Define the email address you want to search for
$email = Read-Host -Prompt "Enter User Email Address."

# Initialize a list to store group names
$groupNames = @()

# Loop through each domain and get user details
foreach ($domainName in $domainNames) {
    Write-Host "Searching in domain: $domainName"

    Write-Host "Attempting to get user details from $domainName"

    # Display the user details
    $user = Get-ADUser -Server $domainName -Filter {EmailAddress -eq $email} -Properties Name, SamAccountName, EmailAddress, Department, Title, MemberOf
    if ($user) {
        Write-Host "User found in $domainName"
        
        # Define the output file path
        $outputFile = Join-Path -Path $resultDir -ChildPath "$($user.SamAccountName).txt"
        
        # Create result directory if it doesn't exist
        if (-not (Test-Path -Path $resultDir)) {
            New-Item -Path $resultDir -ItemType Directory
        }

        # Output user details to the file
        $user | Select-Object Name, SamAccountName, EmailAddress, Department, Title, MemberOf | Out-File -FilePath $outputFile

        # Get the groups the user is a member of
        foreach ($group in $user.MemberOf) {
            try {
                $groupName = (Get-ADGroup -Identity $group).Name
                $groupNames += $groupName
            } catch {
                # Extract and log only the CN part of the group
                if ($group -match "CN=([^,]+)") {
                    $cn = $matches[1]
                    Write-Host "Error querying group $cn in domain $domainName"
                    # Output the CN part even if there's an error
                    $groupNames += $cn
                }
            }
        }

        # Exit the loop once the user is found
        break
    } else {
        Write-Host "User not found in $domainName"
    }
}

# Sort the group names alphabetically
$sortedGroupNames = $groupNames | Sort-Object

# Output the sorted group names to the log file
$sortedGroupNames | Out-File -FilePath $outputFile -Append