[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $ManagementGroupRoot
)

Get-AzPolicyState -ManagementGroupName $ManagementGroupRoot |
Where-Object { $PSItem.ComplianceState -eq "NonCompliant" -and $PSItem.PolicyDefinitionAction -in "DeployIfNotExists", "Modify" } |
Select-Object -Property PolicyAssignmentId, PolicyDefinitionReferenceId -Unique |
ForEach-Object {
    $policyAssignmentId = $PSItem.PolicyAssignmentId
    $policyDefinitionReferenceId = $PSItem.PolicyDefinitionReferenceId
    $remediation = $policyDefinitionReferenceId ? "$policyAssignmentId/$policyDefinitionReferenceId" : $policyAssignmentId

    $running = Get-AzPolicyRemediation -ManagementGroupName $ManagementGroupRoot -Filter "ProvisioningState eq 'Running' && PolicyAssignmentId eq '$policyAssignmentId' && PolicyDefinitionReferenceId eq '$policyDefinitionReferenceId'"

    if ($running) {
        Write-Warning "Remediation for $remediation is already running"
    }
    else {
        Write-Output "Remediating $remediation under $ManagementGroupRoot"
        Start-AzPolicyRemediation -ManagementGroupName $ManagementGroupRoot -PolicyAssignmentId $policyAssignmentId -PolicyDefinitionReferenceId $policyDefinitionReferenceId
    }
}
