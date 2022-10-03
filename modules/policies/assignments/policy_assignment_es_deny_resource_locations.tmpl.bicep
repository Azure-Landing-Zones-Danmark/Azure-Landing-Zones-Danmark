targetScope = 'managementGroup'
resource Deny_Resource_Locations 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Resource-Locations'
  properties: {
    description: 'Specifies the allowed locations (regions) where Resources can be deployed.'
    displayName: 'Limit allowed locations for Resources'
    notScopes: []
    parameters: {
      effect: {
        value: 'deny'
      }
      listOfAllowedLocations: {
        value: [
          'uksouth'
          'ukwest'
        ]
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'e56962a6-4747-49cd-b67b-bf8b01975c4c')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}