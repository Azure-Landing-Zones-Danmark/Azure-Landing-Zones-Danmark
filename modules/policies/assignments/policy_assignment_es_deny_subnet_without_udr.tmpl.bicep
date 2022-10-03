targetScope = 'managementGroup'
resource Deny_Subnet_Without_Udr 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Subnet-Without-Udr'
  properties: {
    description: 'This policy denies the creation of a subnet without a User-Defined Route to control traffic flow.'
    displayName: 'Subnets should have a User-Defined Route'
    notScopes: []
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Subnet-Without-Udr')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}