targetScope = 'managementGroup'

resource Key_Vault_Configure_RBAC_Authorization 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Key-Vault-Configure-RBAC-Authorization'
  properties: {
    displayName: 'Configure Key Vaults to enable RBAC authorization'
    description: 'Enables soft delete'
    mode: 'Indexed'
    metadata: {
      version: '1.0'
      category: 'Key Vault'
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
            equals: 'Microsoft.KeyVault/vaults'
          }
          {
            anyOf: [
              {
                not: {
                  field: 'Microsoft.KeyVault/vaults/enableRbacAuthorization'
                  equals: 'true'
                }
              }
              {
                value: '[empty(field(\'Microsoft.Keyvault/vaults/accessPolicies\'))]'
                equals: 'false'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effectType\')]'
        details: {
          roleDefinitionIds: [
            '/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
          ]
          conflictEffect: 'deny'
          operations: [
            {
              operation: 'addOrReplace'
              field: 'Microsoft.KeyVault/vaults/enableRbacAuthorization'
              value: true
            }
            {
              operation: 'addOrReplace'
              field: 'Microsoft.Keyvault/vaults/accessPolicies'
              value: []
            }
          ]
        }
      }
    }
  }
}
