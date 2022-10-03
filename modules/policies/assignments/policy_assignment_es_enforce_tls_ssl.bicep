targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string

module Enforce_TLS_SSL '../modules/initiative-and-role-assignment.bicep' = {
  name: 'Enforce-TLS-SSL-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Enforce-TLS-SSL'
    policySetDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'Enforce-EncryptTransit')
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
    ]
    parameters: {}
  }
}
