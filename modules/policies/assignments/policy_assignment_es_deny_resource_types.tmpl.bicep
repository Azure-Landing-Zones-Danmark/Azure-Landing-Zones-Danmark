targetScope = 'managementGroup'
resource Deny_Resource_Types 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Resource-Types'
  properties: {
    description: 'Specifies the Resource Types to deny deployment by policy.'
    displayName: 'Deny-Resource-Types'
    notScopes: []
    parameters: {
      effect: {
        value: 'deny'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '6c112d4e-5bc7-47ae-a041-ea2d9dccd749')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}