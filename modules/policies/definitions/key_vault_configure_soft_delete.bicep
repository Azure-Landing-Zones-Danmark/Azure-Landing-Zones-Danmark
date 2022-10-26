targetScope = 'managementGroup'

resource Key_Vault_Configure_Soft_Delete 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Key-Vault-Configure-Soft-Delete'
  properties: {
    displayName: 'Configure Key Vaults to enable soft delete'
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
            not: {
              field: 'Microsoft.KeyVault/vaults/enableSoftDelete'
              equals: 'true'
            }
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
              field: 'Microsoft.KeyVault/vaults/enableSoftDelete'
              value: true
            }
          ]
        }
      }
    }
  }
}
