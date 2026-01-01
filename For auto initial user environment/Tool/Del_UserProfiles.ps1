# Exclude specific profile names (NOT substring "user")
$excludeNames = @('Default', 'Default User', 'Public', 'All Users', 'Administrator')
$excludePrefixPattern = '^e1|p1'   # exclude names starting with e1 or p1.

$profiles = Get-CimInstance Win32_UserProfile | Where-Object { $_.Special -eq $false }

foreach ($p in $profiles) {
    $name = Split-Path $p.LocalPath -Leaf

    # Skip excluded names/patterns
    if ($excludeNames -contains $name -or $name -match $excludePrefixPattern) {
        Write-Output "Skipped profiles: $($p.LocalPath)"
        continue
    }

    # Skip loaded profiles (typically cannot delete)
    if ($p.Loaded) {
        Write-Output "Skipped (loaded) profiles: $($p.LocalPath)"
        continue
    }

    Write-Output "User profiles: $($p.LocalPath)"
    $response = Read-Host "Delete this? (y/n)"
    if ($response -eq 'y') {
        try {
            Invoke-CimMethod -InputObject $p -MethodName Delete | Out-Null
            Write-Output "Deleted profiles: $($p.LocalPath)"
        } catch {
            Write-Output "Delete failed profiles: $($p.LocalPath) - $($_.Exception.Message)"
        }
    } else {
        Write-Output "Skipped profiles: $($p.LocalPath)"
    }
}

