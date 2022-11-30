# This script will export Azure custom policies, custom initiatives and assignments to .csv files
# the .csv files can then be added to the Security Control mapping .xls 'Danmark-azure-security-benchmark-v3.0.xlsx'
# and used to map existing policy into baseline recommendations in order to calculate a delta of policies that are candidates for deployment


# uncomment the following two lines to install the Azure Powershell Module
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

Connect-AzAccount -Tenant 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX'

# Export Custom policy
Get-AzPolicyDefinition -custom | Select-Object Name, PolicyDefinitionId | export-csv -path customPolicies.csv -NoTypeInformation

# Export Custom Initiatives
$customInitiatives = Get-AzPolicySetDefinition -Custom | Select-Object Name, PolicySetDefinitionId -ExpandProperty Properties | select-object Name, PolicySetDefinitionId -ExpandProperty PolicyDefinitions
$customInitiatives = $customInitiatives | select-object Name, PolicySetDefinitionId, policyDefinitionReferenceId, policyDefinitionId | Export-Csv -Path customInitatives.csv -NoTypeInformation

# Export Policy Assignments
$results = new-object -Type System.Collections.ArrayList
Foreach($policyAssignment In Get-AzPolicyAssignment )
{
    $assignments = New-Object PSObject
    Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Assignment Name' -Value $policyAssignment.Name
    Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Assignment ID' -Value $policyAssignment.PolicyAssignmentId
    If($policyAssignment.Properties.PolicyDefinitionId -match "policyDefinitions"){
        $PolicyDefinition = Get-AzPolicyDefinition -Id $policyAssignment.Properties.PolicyDefinitionId | Select-Object ResourceName, PolicyDefinitionId -ExpandProperty Properties | Select-Object ResourceName, PolicyDefinitionId, DisplayName
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Policy Definition Reference ID' -Value $PolicyDefinition.ResourceName
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Policy Definition ID' -value $PolicyDefinition.PolicyDefinitionId
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Policy Definition Display Name' -value $PolicyDefinition.DisplayName

        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Initiative Name' -value  $null
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Initiative ID' -value  $null
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Initiative Policy definitions reference ids' -value  $null
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Initiative Policy definitions ids' -value  $null

    }
    elseif ($policyAssignment.Properties.PolicyDefinitionId -match "policySetDefinitions"){
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Policy Definition Reference ID' -Value $null
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Policy Definition ID' -value $null
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Policy Definition Display Name' -value $null

        $PolicySetDefinition = Get-AzPolicySetDefinition -Id $policyAssignment.Properties.PolicyDefinitionId | Select-Object Name, PolicySetDefinitionId -ExpandProperty Properties
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Initiative Name' -value $PolicySetDefinition.Name
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Initiative ID' -value $PolicySetDefinition.PolicySetDefinitionId
        $strRefids = [system.string]::join(" ", $PolicySetDefinition.policyDefinitions.policyDefinitionReferenceId)
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Initiative Policy definitions reference ids' -value $strRefids
        $strids = [system.string]::join(" ",$PolicySetDefinition.policyDefinitions.policyDefinitionId)
        Add-Member -InputObject $assignments -MemberType NoteProperty -Name 'Initiative Policy definitions ids' -value $strids
    }
    else {
        # shouldn't hit this section of the code
        write-error "Unknown"
        write-error $policyAssignment.Properties.PolicyDefinitionId
    }
    $results += $assignments
}
$results | export-csv -path 'assignments.csv' -NoTypeInformation
