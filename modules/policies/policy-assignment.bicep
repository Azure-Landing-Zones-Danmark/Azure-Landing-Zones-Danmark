targetScope = 'managementGroup'

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
  properties: {
    displayName: empty(policyAssignmentDisplayName) ? reference(policyDefinitionId, '2020-09-01').displayName : policyAssignmentDisplayName
    description: empty(policyAssignmentDescription) ? reference(policyDefinitionId, '2020-09-01').description : policyAssignmentDescription
    enforcementMode: enforcementMode
    policyDefinitionId: policyDefinitionId
    parameters: parameters
    notScopes: notScopes
  }
}
