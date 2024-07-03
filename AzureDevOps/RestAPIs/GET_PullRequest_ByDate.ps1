# Variables
$organization = "techtonicshift"  # Replace with your Azure DevOps organization
$project = ""  # Replace with your Azure DevOps project name or ID
$repositoryId = ""  # Replace with your repository ID
$pat = ""  # Replace with your Personal Access Token

# Date range
$startDate = "2024-01-01T00:00:00Z"  # Replace with your start date in YYYY-MM-DDTHH:mm:ssZ format
$endDate = "2024-12-31T23:59:59Z"    # Replace with your end date in YYYY-MM-DDTHH:mm:ssZ format

# Encode PAT
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

# API URL
$uri = "https://dev.azure.com/$organization/$project/_apis/git/pullrequests?api-version=7.1-preview.1&searchCriteria.repositoryId=$repositoryId&searchCriteria.minTime=$startDate&searchCriteria.maxTime=$endDate"

# Debug logging
Write-Output "Organization: $organization"
Write-Output "Project: $project"
Write-Output "Repository ID: $repositoryId"
Write-Output "Start Date: $startDate"
Write-Output "End Date: $endDate"
Write-Output "API URL: $uri"

try {
    # Make the REST API call
    $response = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}

    # Debug: Output the raw response
    Write-Output "Raw API Response: $($response | ConvertTo-Json -Depth 10)"

    # Check if the response is empty
    if ($null -eq $response.value -or $response.value.Count -eq 0) {
        Write-Output "No pull requests found in the specified date range."
    } else {
        # Output the pull requests
        $response.value | ForEach-Object {
            Write-Output "Pull Request ID: $($_.pullRequestId)"
            Write-Output "Title: $($_.title)"
            Write-Output "Created By: $($_.createdBy.displayName)"
            Write-Output "Creation Date: $($_.creationDate)"
            Write-Output "Status: $($_.status)"
            Write-Output "-----------------------------------"
        }
    }
} catch {
    Write-Output "Error: $($_.Exception.Message)"
}
