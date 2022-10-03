targetScope = 'managementGroup'
resource Deny_RSG_Locations 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-RSG-Locations'
  properties: {
    description: 'Specifies the allowed locations (regions) where Resource Groups can be deployed.'
    displayName: 'Limit allowed locations for Resource Groups'
    notScopes: []
    parameters: {
      effect: {
        value: 'deny'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'e765b5de-1225-4ba3-bd56-1ac6695af988')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}