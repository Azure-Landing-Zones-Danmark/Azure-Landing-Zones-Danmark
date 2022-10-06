[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Prefix
)

Get-AzPolicyState -ManagementGroupName $Prefix |
Where-Object { $PSItem.ComplianceState -eq "NonCompliant" -and $PSItem.PolicyDefinitionAction -in "DeployIfNotExists", "Modify" } |
Select-Object PolicyAssignmentId, PolicyDefinitionReferenceId -Unique |
ForEach-Object {
    $policyAssignmentId = $PSItem.PolicyAssignmentId
    $policyDefinitionReferenceId = $PSItem.PolicyDefinitionReferenceId
    $remediation = $policyDefinitionReferenceId ? "$policyAssignmentId/$policyDefinitionReferenceId" : $policyAssignmentId

    $running = Get-AzPolicyRemediation -ManagementGroupName $Prefix -Filter "PolicyAssignmentId eq '$policyAssignmentId' and PolicyDefinitionReferenceId eq '$policyDefinitionReferenceId'" | Where-Object ProvisioningState -ne "Running"

    if ($running) {
        Write-Warning "Remediation for $remediation is already running"
    }
    else {
        Write-Output "Remediating $remediation under $Prefix"
        if ($policyDefinitionReferenceId) {
            Start-AzPolicyRemediation -Name (New-Guid) -ManagementGroupName $Prefix -PolicyAssignmentId $policyAssignmentId -PolicyDefinitionReferenceId $policyDefinitionReferenceId
        }
        else {
            Start-AzPolicyRemediation -Name (New-Guid) -ManagementGroupName $Prefix -PolicyAssignmentId $policyAssignmentId
        }
    }
}
