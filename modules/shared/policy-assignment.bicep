targetScope = 'managementGroup'

param location string = deployment().location
@maxLength(24)
param policyAssignmentName string
param policyAssignmentDisplayName string = ''
param policyAssignmentDescription string = ''
param policyDefinitionId string
param userAssignedManagedIdentity string = ''
@allowed([
  'Default'
  'DoNotEnforce'
])
param enforcementMode string = 'Default'
param parameters object = {}
param notScopes array = []

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: policyAssignmentName
  location: location
  identity: empty(userAssignedManagedIdentity) ? { type: 'None' } : {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedManagedIdentity}': {}
    }
  }
  properties: {
    displayName: empty(policyAssignmentDisplayName) ? reference(policyDefinitionId, '2021-06-01').displayName : policyAssignmentDisplayName
    description: empty(policyAssignmentDescription) ? reference(policyDefinitionId, '2021-06-01').description : policyAssignmentDescription
    enforcementMode: enforcementMode
    policyDefinitionId: policyDefinitionId
    parameters: parameters
    notScopes: notScopes
  }
}
