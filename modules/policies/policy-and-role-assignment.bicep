targetScope = 'managementGroup'

param location string = deployment().location
@maxLength(24)
param policyAssignmentName string
param policyAssignmentDisplayName string = ''
param policyAssignmentDescription string = ''
param policyDefinitionId string
@allowed([
  'Default'
  'DoNotEnforce'
])
param enforcementMode string = 'Default'
param parameters object = {}
param notScopes array = []

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: policyAssignmentName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    displayName: empty(policyAssignmentDisplayName) ? reference(policyDefinitionId, '2020-09-01').displayName : policyAssignmentDisplayName
    description: empty(policyAssignmentDescription) ? reference(policyDefinitionId, '2020-09-01').description : policyAssignmentDescription
    enforcementMode: enforcementMode
    policyDefinitionId: policyDefinitionId
    parameters: parameters
    notScopes: notScopes
  }
}

module roleAssignment './internal/role-assignment-multiple.bicep' = {
  name: 'role-assignment-${uniqueString(policyDefinitionId)}'
  params: {
    roleDefinitionIds: reference(policyDefinitionId, '2020-09-01', 'Full').properties.policyRule.then.details.roleDefinitionIds
    principalId: reference(policyAssignment.id, '2020-03-01', 'Full').identity.principalId
  }
}

output managedIdentityId string = policyAssignment.identity.principalId
