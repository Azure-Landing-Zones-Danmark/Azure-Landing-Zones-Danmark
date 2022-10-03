targetScope = 'managementGroup'
resource Deny_PublicEndpoint_MariaDB 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-PublicEndpoint-MariaDB'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Public network access should be disabled for MariaDB'
    description: 'This policy denies the creation of Maria DB accounts with exposed public endpoints'
    metadata: {
      version: '1.0.0'
      category: 'SQL'
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
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.DBforMariaDB/servers'
          }
          {
            field: 'Microsoft.DBforMariaDB/servers/publicNetworkAccess'
            notequals: 'Disabled'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}