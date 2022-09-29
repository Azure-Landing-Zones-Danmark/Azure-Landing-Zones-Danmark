targetScope = 'managementGroup'

param roleDefinitionIds array
param principalId string

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = [for roleDefinitionId in roleDefinitionIds: {
  name: guid(principalId, roleDefinitionId, managementGroup().id)
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}]
