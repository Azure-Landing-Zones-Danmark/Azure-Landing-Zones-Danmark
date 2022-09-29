[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $PolicySetDefinitionId
)

function Get-Name($Id) {
    $Id -split "/" | Select-Object -Last 1
}

function Get-ManagementGroupName($Id) {
    if ($Id -match "/Microsoft.Management/managementGroups/([^/]+)/") {
        $Matches.1
    }
    else {
        (az account show --query tenantId --output tsv)
    }
}

$policySetDefinitionName = Get-Name -Id $PolicySetDefinitionId
$managementGroupName = Get-ManagementGroupName -Id $PolicySetDefinitionId

Write-Verbose "Getting initiative definition: '$PolicySetDefinitionId'"
$policySet = (az policy set-definition show --management-group $managementGroupName --name $policySetDefinitionName) | ConvertFrom-Json

$roleDefinitionIds = [System.Collections.Generic.HashSet[String]]::new([System.StringComparer]::InvariantCultureIgnoreCase)

$policySet.policyDefinitions | ForEach-Object {
    $policyDefinitionId = $PSItem.policyDefinitionId
    $policyDefinitionName = Get-Name -Id $policyDefinitionId
    $managementGroupName = Get-ManagementGroupName -Id $policyDefinitionId
    Write-Verbose "Getting policy definition: '$policyDefinitionId'"
    $policyDefinition = (az policy definition show --management-group $managementGroupName --name $policyDefinitionName) | ConvertFrom-Json
    $policyDefinition.policyRule.then.details.roleDefinitionIds | ForEach-Object {
        $roleDefinitionIds.Add($PSItem) | Out-Null
    }
}

$roleDefinitionIds | Sort-Object
