targetScope = 'managementGroup'

resource Redis_Configure_Minimum_TLS 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Redis-Configure-Minimum-TLS'
  properties: {
    displayName: 'Configure Azure Cache for Redis to use the latest TLS version'
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'Upgrade to the latest TLS version.'
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
                field: 'Microsoft.Cache/Redis/minimumTlsVersion'
                exists: 'false'
              }
              {
                field: 'Microsoft.Cache/Redis/minimumTlsVersion'
                notEquals: '1.2'
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
              field: 'Microsoft.Cache/redis/minimumTlsVersion'
              value: '1.2'
            }
          ]
        }
      }
    }
  }
}
