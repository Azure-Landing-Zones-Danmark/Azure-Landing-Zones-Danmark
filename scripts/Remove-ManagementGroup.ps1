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
    $scope = $PSItem.Id
    $name = $PSItem.Name
    $displayName = $PSItem.DisplayName

    Write-Verbose "Removing policy assignments from management group '$displayName'..."

    Get-AzPolicyAssignment -Scope $scope | Where-Object { $PSItem.Properties.Scope -eq $scope } | Remove-AzPolicyAssignment

    Write-Verbose "Removing initiatives from management group '$displayName'..."

    Get-AzPolicySetDefinition -ManagementGroupName $name | Remove-AzPolicySetDefinition

    Write-Verbose "Removing policy definitions from management group '$displayName'..."

    Get-AzPolicyDefinition -ManagementGroupName $name | Remove-AzPolicyDefinition

    Get-AzManagementGroupSubscription -GroupName $name | ForEach-Object {
        $subscriptionId = $PSItem.Id -split "/" | Select-Object -Last 1
        Write-Verbose "Moving subscription $($PSItem.DisplayName) to /"
        New-AzManagementGroupSubscription -GroupName $tenantId -SubscriptionId $subscriptionId
    }

    Write-Verbose "Removing management group '$displayName'..."

    Remove-AzManagementGroup -GroupName $name
}
