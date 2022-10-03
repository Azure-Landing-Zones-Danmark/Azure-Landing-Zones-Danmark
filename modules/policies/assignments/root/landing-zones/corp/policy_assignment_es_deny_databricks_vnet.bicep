targetScope = 'managementGroup'
resource Deny_DataB_Vnet 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-DataB-Vnet'
  properties: {
    description: 'Enforces the use of vnet injection for Databricks workspaces.'
    displayName: 'Enforces the use of vnet injection for Databricks'
    notScopes: []
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-VirtualNetwork')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}