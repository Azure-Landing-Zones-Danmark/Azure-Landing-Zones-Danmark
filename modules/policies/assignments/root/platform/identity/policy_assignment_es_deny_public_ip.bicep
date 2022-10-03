targetScope = 'managementGroup'
resource Deny_Public_IP 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Public-IP'
  properties: {
    description: 'This policy denies creation of Public IPs under the assigned scope.'
    displayName: 'Deny the creation of public IP'
    notScopes: []
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-PublicIP')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}