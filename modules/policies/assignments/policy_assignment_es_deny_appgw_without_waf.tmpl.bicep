targetScope = 'managementGroup'
resource Deny_AppGW_Without_WAF 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-AppGW-Without-WAF'
  properties: {
    description: 'Deny creation of App Gateway without WAF.'
    displayName: 'Deny-AppGW-Without-WAF'
    notScopes: []
    parameters: {
      effect: {
        value: 'deny'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-AppGW-Without-WAF')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}