targetScope = 'managementGroup'

resource Configure_Key_Vault_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-Key-Vault-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure security settings for Key Vaults'
    description: 'This policy initiative is a group of policies that configures security settings Key Vaults.'
    metadata: {
      version: '1.0'
      category: 'Key Vault'
    }
    parameters: {}
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureKeyVaultsToEnableFirewall'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'ac673a9a-f77d-4846-b2d8-a57f8e1c01dc')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureKeyVaultsToEnablePurgeProtection'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Key-Vault-Configure-Purge-Protection')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureKeyVaultsToEnableSoftDelete'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Key-Vault-Configure-Soft-Delete')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureKeyVaultsToEnableRbacAuthorization'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Key-Vault-Configure-RBAC-Authorization')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
