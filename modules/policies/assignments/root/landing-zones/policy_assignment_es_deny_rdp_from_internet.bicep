targetScope = 'managementGroup'
resource Deny_RDP_From_Internet 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-RDP-From-Internet'
  properties: {
    description: 'This policy denies any network security rule that allows RDP access from Internet.'
    displayName: 'RDP access from the Internet should be blocked'
    notScopes: []
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-RDP-From-Internet')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}