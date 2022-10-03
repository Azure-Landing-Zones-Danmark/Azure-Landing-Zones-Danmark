targetScope = 'managementGroup'
resource Append_KV_SoftDelete 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Append-KV-SoftDelete'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'KeyVault SoftDelete should be enabled'
    description: 'This policy enables you to ensure when a Key Vault is created with out soft delete enabled it will be added.'
    metadata: {
      version: '1.0.0'
      category: 'Key Vault'
    }
    parameters: {
    }
    policyRule: {
      if: {
        anyOf: [
          {
            allOf: [
              {
                field: 'type'
                equals: 'Microsoft.KeyVault/vaults'
              }
              {
                field: 'Microsoft.KeyVault/vaults/enableSoftDelete'
                notEquals: true
              }
            ]
          }
        ]
      }
      then: {
        effect: 'append'
        details: [
          {
            field: 'Microsoft.KeyVault/vaults/enableSoftDelete'
            value: true
          }
        ]
      }
    }
  }
}