targetScope = 'managementGroup'

param location string = deployment().location
@maxLength(24)
param policyAssignmentName string
param policyAssignmentDisplayName string = ''
param policyAssignmentDescription string = ''
param policySetDefinitionId string
param roleDefinitionIds array
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
    displayName: empty(policyAssignmentDisplayName) ? reference(policySetDefinitionId, '2020-09-01').displayName : policyAssignmentDisplayName
    description: empty(policyAssignmentDescription) ? reference(policySetDefinitionId, '2020-09-01').description : policyAssignmentDescription
    enforcementMode: enforcementMode
    policyDefinitionId: policySetDefinitionId
    parameters: parameters
    notScopes: notScopes
  }
}

module policyRoleAssignment './internal/role-assignment-multiple.bicep' = {
  name: 'policy-role-assignment-${uniqueString(policySetDefinitionId)}'
  params: {
    roleDefinitionIds: roleDefinitionIds
    principalId: reference(policyAssignment.id, '2020-03-01', 'Full').identity.principalId
  }
}

output managedIdentityId string = policyAssignment.identity.principalId
