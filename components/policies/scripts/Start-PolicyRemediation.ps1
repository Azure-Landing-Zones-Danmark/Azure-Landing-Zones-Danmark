[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Path
)

Get-ChildItem -Path $Path -Recurse -Directory | Sort-Object -Property FullName | ForEach-Object {
    $managementGroupId = $PSItem.Name
    Write-Verbose "Remediating policies under $managementGroupId..."
    (az policy state list --management-group $managementGroupId --query "[?complianceState=='NonCompliant' && (policyDefinitionAction=='deployifnotexists' || policyDefinitionAction=='modify')].{policyAssignmentId:policyAssignmentId, policyDefinitionReferenceId:policyDefinitionReferenceId}") |
    ConvertFrom-Json |
    Select-Object -Property policyAssignmentId, policyDefinitionReferenceId -Unique |
    ForEach-Object {
        $policyAssignmentId = $PSItem.policyAssignmentId
        $policyDefinitionReferenceId = $PSItem.policyDefinitionReferenceId
        $remediation = $policyDefinitionReferenceId ? "$policyAssignmentId/$policyDefinitionReferenceId" : $policyAssignmentId
        $running = (az policy remediation list --management-group $managementGroupId --query "[?provisioningState=='Running' && policyAssignmentId=='$policyAssignmentId' && policyDefinitionReferenceId == '$policyDefinitionReferenceId']") | ConvertFrom-Json
        if ($running) {
            Write-Warning -Message "Remediation for $remediation is already running"
        }
        else {
            if ($policyDefinitionReferenceId) {
                Write-Verbose -Message "Remediating $remediation under $managementGroupId"
                az policy remediation create --name (New-Guid) --management-group $managementGroupId --policy-assignment $policyAssignmentId --definition-reference-id $policyDefinitionReferenceId
            }
            else {
                Write-Verbose -Message "Remediating $remediation under $managementGroupId"
                az policy remediation create --name (New-Guid) --management-group $managementGroupId --policy-assignment $policyAssignmentId
            }
        }
    }
}
