# Variables
$organization = "techtonicshift" # Replace with your Azure DevOps organization
$project = "" #  # Replace with your Azure DevOps project name or ID
$pat = "" # Replace with your Personal Access Token

# Encode PAT
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

# API URL for listing repositories
$uri = "https://dev.azure.com/$organization/$project/_apis/git/repositories?api-version=6.0"

try {
    # Make the REST API call
    $response = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}

    # Output the repositories
    $response.value | ForEach-Object {
        Write-Output "Repository Name: $($_.name)"
        Write-Output "Repository ID: $($_.id)"
        Write-Output "-----------------------------------"
    }
} catch {
    Write-Output "Error: $($_.Exception.Message)"
}
