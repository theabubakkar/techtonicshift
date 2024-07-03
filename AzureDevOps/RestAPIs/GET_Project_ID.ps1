# Variables
$organization = "techtonicshift"  # Replace with your Azure DevOps organization
$pat = "" # Replace with your Personal Access Token

# Encode PAT
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

# API URL
$uri = "https://dev.azure.com/$organization/_apis/projects?api-version=6.0"

# Make the REST API call
$response = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}

# Output the project names and IDs
$response.value | ForEach-Object {
    Write-Output "Project Name: $($_.name)"
    Write-Output "Project ID: $($_.id)"
    Write-Output "-----------------------------------"
}
