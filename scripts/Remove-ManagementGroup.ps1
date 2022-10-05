<#
.DESCRIPTION
Remove all management groups in hierarchy up to and including prefix
#>
[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Prefix
)

$tenantId = (Get-AzContext).Tenant.Id

Get-AzManagementGroup | Where-Object Name -match "^$Prefix" | Sort-Object -Descending | ForEach-Object {
    Write-Verbose "Removing policy assignments from management group '$displayName'..."

    Get-AzPolicyAssignment -Scope $PSItem.Id | Remove-AzPolicyAssignment

    Write-Verbose "Removing initiatives from management group '$displayName'..."

    Get-AzPolicySetDefinition -ManagementGroupName $PSItem.Name | Remove-AzPolicySetDefinition

    Write-Verbose "Removing policy definitions from management group '$displayName'..."

    Get-AzPolicyDefinition -ManagementGroupName $PSItem.Name | Remove-AzPolicyDefinition

    Get-AzManagementGroupSubscription -GroupName $group.Name | ForEach-Object {
        $subscriptionId = $PSItem.Id -split "/" | Select-Object -Last 1
        Write-Verbose "Moving subscription $($PSItem.DisplayName) to /"
        New-AzManagementGroupSubscription -GroupName $tenantId -SubscriptionId $subscriptionId
    }

    Write-Verbose "Removing management group '$displayName'..."

    Remove-AzManagementGroup -GroupName $name
}
