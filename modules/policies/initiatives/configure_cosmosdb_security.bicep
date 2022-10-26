targetScope = 'managementGroup'

resource Configure_CosmosDB_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-CosmosDB-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure Cosmos DB security'
    description: 'This policy initiative is a group of policies that configures Cosmos DB security.'
    metadata: {
      version: '1.0'
      category: 'Cosmos DB'
    }
    parameters: {}
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureCosmosDbDatabaseAccountsToDisableLocalAuthentication'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'dc2d41d1-4ab1-4666-a3e1-3d51c43e0049')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureCosmosdbAccountsToDisablePublicNetworkAccess'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'da69ba51-aaf1-41e5-8651-607cd0b37088')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployAdvancedThreatProtectionForCosmosDbAccounts'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'b5f04e03-92a3-4b09-9410-2cc5e5047656')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
