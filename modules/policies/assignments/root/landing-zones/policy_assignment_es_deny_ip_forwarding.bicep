targetScope = 'managementGroup'
resource Deny_IP_Forwarding 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-IP-Forwarding'
  properties: {
    description: 'This policy denies the network interfaces which enabled IP forwarding. The setting of IP forwarding disables Azure\'s check of the source and destination for a network interface. This should be reviewed by the network security team.'
    displayName: 'Network interfaces should disable IP forwarding'
    notScopes: []
    parameters: {
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '88c0b9da-ce96-4b03-9635-f29a937e2900')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}