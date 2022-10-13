targetScope = 'managementGroup'

resource Redis_Configure_Disable_NonSSL 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Redis-Configure-Disable-NonSSL'
  properties: {
    displayName: 'Configure Azure Cache for Redis to use the latest TLS version'
    description: 'Disable non-ssl port.'
    policyType: 'Custom'
    mode: 'Indexed'
    metadata: {
      version: '1.0'
      category: 'Cache'
    }
    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'Modify'
          'Disabled'
        ]
        defaultValue: 'Modify'
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Cache/redis'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.Cache/Redis/enableNonSslPort'
                exists: false
              }
              {
                field: 'Microsoft.Cache/Redis/enableNonSslPort'
                equals: 'true'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/e0f68234-74aa-48ed-b826-c38b57376e17'
          ]
          conflictEffect: 'audit'
          operations: [
            {
              operation: 'addOrReplace'
              field: 'Microsoft.Cache/redis/enableNonSslPort'
              value: false
            }
          ]
        }
      }
    }
  }
}
