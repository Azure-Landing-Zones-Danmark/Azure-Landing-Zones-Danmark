targetScope = 'managementGroup'

resource StorageAccountModifySecurityControls 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'StorageAccountModifySecurityControls'
  properties: {
    displayName: 'Modify encryption in transit on Storage Accounts'
    description: 'Modify encryption in transit for with HTTPS and TLS 1.2 on Storage Accounts'
    mode: 'Indexed'
    metadata: {
      category: 'Storage'
    }
    parameters: {
      effectType: {
        type: 'String'
        defaultValue: 'Modify'
        allowedValues: [
          'Disabled'
          'Modify'
        ]
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            anyOf: [
              {
                not: {
                  field: 'Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly'
                  equals: 'true'
                }
              }
              {
                not: {
                  field: 'Microsoft.Storage/storageAccounts/minimumTlsVersion'
                  equals: 'TLS1_2'
                }
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effectType\')]'
        details: {
          roleDefinitionIds: [
            '/providers/Microsoft.Authorization/roleDefinitions/17d1049b-9a84-46fb-8f53-869881c3d3ab'
          ]
          conflictEffect: 'deny'
          operations: [
            {
              operation: 'addOrReplace'
              field: 'Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly'
              value: true
            }
            {
              operation: 'addOrReplace'
              field: 'Microsoft.Storage/storageAccounts/minimumTlsVersion'
              value: 'TLS1_2'
            }
          ]
        }
      }
    }
  }
}
