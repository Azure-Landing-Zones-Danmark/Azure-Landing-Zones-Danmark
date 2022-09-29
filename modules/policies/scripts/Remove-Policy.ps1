[CmdletBinding(SupportsShouldProcess)]
param ()

function Remove-PolicyDefinition {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        $Name,
        $ManagementGroup
    )

    Write-Verbose "Deleting policy definition $Name from management group: $ManagementGroup"

    if($PSCmdlet.ShouldProcess($Name)){
        (az policy definition delete --name $Name --management-group $ManagementGroup)
    }
}

function Remove-Initiative {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        $Name,
        $ManagementGroup
    )

    Write-Verbose "Deleting initiative $Name from management group: $ManagementGroup"

    if($PSCmdlet.ShouldProcess($Name)){
        (az policy set-definition delete --name $Name --management-group $ManagementGroup)
    }
}

function Remove-PolicyAssignment {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        $Name,
        $Scope
    )

    Write-Verbose "Deleting assignment $Name from scope: $Scope"

    if($PSCmdlet.ShouldProcess($Name)){
        (az policy assignment delete --name $Name --scope $Scope)
    }
}

$managementGroups = (az account management-group list) | ConvertFrom-Json

$definitions = @()
$initiatives = @()
$assignments = @()

$managementGroups | ForEach-Object {
    $managementGroup = $PSItem.name
    Write-Verbose "Getting policy definitions and assignments from management group: $managementGroup"
    $definitions += (az policy definition list --management-group $managementGroup --query "[?policyType=='Custom' && starts_with(id, '/providers/Microsoft.Management/managementGroups/$managementGroup/')]") | ConvertFrom-Json
    $initiatives += (az policy set-definition list --management-group $managementGroup --query "[?policyType=='Custom' && starts_with(id, '/providers/Microsoft.Management/managementGroups/$managementGroup/')]") | ConvertFrom-Json
    $assignments += (az policy assignment list --scope $PSItem.id) | ConvertFrom-Json
}

$assignments | ForEach-Object {
    Remove-PolicyAssignment -Name $PSItem.name -Scope $PSItem.scope
}

$initiatives | ForEach-Object {
    $PSItem.id -match "/providers/Microsoft.Management/managementGroups/([^/]+)/providers/Microsoft.Authorization/policySetDefinitions/.+" | Out-Null
    Remove-Initiative -Name $PSItem.name -ManagementGroup $Matches[1]
}

$definitions | ForEach-Object {
    $PSItem.id -match "/providers/Microsoft.Management/managementGroups/([^/]+)/providers/Microsoft.Authorization/policyDefinitions/.+" | Out-Null
    Remove-PolicyDefinition -Name $PSItem.name -ManagementGroup $Matches[1]
}
