targetScope = 'managementGroup'
resource Deny_Subnet_Without_Nsg 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Subnet-Without-Nsg'
  properties: {
    description: 'This policy denies the creation of a subnet without a Network Security Group to protect traffic across subnets.'
    displayName: 'Subnets should have a Network Security Group'
    notScopes: []
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Subnet-Without-Nsg')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}