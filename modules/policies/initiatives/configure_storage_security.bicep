targetScope = 'managementGroup'

resource Configure_Storage_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-Storage-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure security settings for Storage'
    description: 'This policy initiative is a group of policies that configures security settings Storage.'
    metadata: {
      version: '1.0'
      category: 'Storage'
    }
      parameters: {}
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureSecureTransferOfDataOnAStorageAccount'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'f81e3117-0093-4b17-8a60-82363134f0eb')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureYourStorageAccountPublicAccessToBeDisallowed'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '13502221-8df0-4414-9937-de9c5c4e396b')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureStorageAccountsToDisablePublicNetworkAccess'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a06d0189-92e8-4dba-b0c4-08d7669fce7d')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
