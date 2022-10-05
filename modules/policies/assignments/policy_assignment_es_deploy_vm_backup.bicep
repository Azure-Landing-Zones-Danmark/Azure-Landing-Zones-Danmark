targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string

module Deploy_VM_Backup '../modules/policy-and-role-assignment.bicep' = {
  name: 'Deploy-VM-Backup-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deploy-VM-Backup'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '98d0b9f8-fd90-49c9-88e2-d3baf3b0dd86')
    location: location
    parameters: {
      effect: {
        value: 'deployIfNotExists'
      }
    }
  }
}
