targetScope = 'managementGroup'

param scope string // required to create a unique name for the role assignment as there is currently no function to retrieve it dynamically
param roleDefinitionId string
param principalId string
@allowed([
  'ForeignGroup'
  'Group'
  'ServicePrincipal'
  'User'
])
param principalType string

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: guid(principalId, roleDefinitionId, scope)
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: principalId
    principalType: principalType
  }
}
