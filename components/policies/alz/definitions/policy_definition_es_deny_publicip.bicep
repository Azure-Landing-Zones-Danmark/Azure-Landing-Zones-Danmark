targetScope = 'managementGroup'
resource Deny_PublicIP 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-PublicIP'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Deny the creation of public IP'
    description: 'This policy denies creation of Public IPs under the assigned scope.'
    metadata: {
      version: '1.0.0'
      category: 'Network'
    }
    parameters: {
      effect: {
        type: 'String'
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
      }
    }
    policyRule: {
      if: {
        field: 'type'
        equals: 'Microsoft.Network/publicIPAddresses'
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}