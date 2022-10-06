[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $ManagementGroupRoot
)

Get-AzPolicyState -ManagementGroupName $ManagementGroupRoot |
Where-Object { $PSItem.ComplianceState -eq "NonCompliant" -and $PSItem.PolicyDefinitionAction -in "DeployIfNotExists", "Modify" } |
Select-Object PolicyAssignmentId, PolicyDefinitionReferenceId -Unique |
ForEach-Object {
    $policyAssignmentId = $PSItem.PolicyAssignmentId
    $policyDefinitionReferenceId = $PSItem.PolicyDefinitionReferenceId
    $remediation = $policyDefinitionReferenceId ? "$policyAssignmentId/$policyDefinitionReferenceId" : $policyAssignmentId

    $running = Get-AzPolicyRemediation -ManagementGroupName $ManagementGroupRoot -Filter "PolicyAssignmentId eq '$policyAssignmentId' and PolicyDefinitionReferenceId eq '$policyDefinitionReferenceId'" | Where-Object ProvisioningState -ne "Running"

    if ($running) {
        Write-Warning "Remediation for $remediation is already running"
    }
    else {
        Write-Output "Remediating $remediation under $ManagementGroupRoot"
        if ($policyDefinitionReferenceId) {
            Start-AzPolicyRemediation -Name (New-Guid) -ManagementGroupName $ManagementGroupRoot -PolicyAssignmentId $policyAssignmentId -PolicyDefinitionReferenceId $policyDefinitionReferenceId
        }
        else {
            Start-AzPolicyRemediation -Name (New-Guid) -ManagementGroupName $ManagementGroupRoot -PolicyAssignmentId $policyAssignmentId
        }
    }
}
