targetScope = 'managementGroup'
resource Deny_Subnet_Without_Udr 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-Subnet-Without-Udr'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Subnets should have a User Defined Route'
    description: 'This policy denies the creation of a subnet without a User Defined Route (UDR).'
    metadata: {
      version: '2.0.0'
      category: 'Network'
    }
    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      excludedSubnets: {
        type: 'Array'
        metadata: {
          displayName: 'Excluded Subnets'
          description: 'Array of subnet names that are excluded from this policy'
        }
        defaultValue: [
          'AzureBastionSubnet'
        ]
      }
    }
    policyRule: {
      if: {
        anyOf: [
          {
            allOf: [
              {
                equals: 'Microsoft.Network/virtualNetworks'
                field: 'type'
              }
              {
                count: {
                  field: 'Microsoft.Network/virtualNetworks/subnets[*]'
                  where: {
                    allOf: [
                      {
                        exists: false
                        field: 'Microsoft.Network/virtualNetworks/subnets[*].routeTable.id'
                      }
                      {
                        field: 'Microsoft.Network/virtualNetworks/subnets[*].name'
                        notIn: '[parameters(\'excludedSubnets\')]'
                      }
                    ]
                  }
                }
                notEquals: 0
              }
            ]
          }
          {
            allOf: [
              {
                field: 'type'
                equals: 'Microsoft.Network/virtualNetworks/subnets'
              }
              {
                field: 'name'
                notIn: '[parameters(\'excludedSubnets\')]'
              }
              {
                field: 'Microsoft.Network/virtualNetworks/subnets/routeTable.id'
                exists: false
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}
