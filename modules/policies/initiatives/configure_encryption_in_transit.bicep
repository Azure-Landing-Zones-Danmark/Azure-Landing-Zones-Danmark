targetScope = 'managementGroup'

resource Configure_Encryption_in_Transit 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-Encryption-in-Transit'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure encryption in transit for PaaS services'
    description: 'This policy initiative is a group of policies that configures encryption in transit for Azure PaaS services'
    metadata: {}
    parameters: {}
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppSlotsToUseTheLatestTlsVersion'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '014664e7-e348-41a3-aeb9-566e4ff6a9df')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppsToUseTheLatestTlsVersion'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '1f01f1c7-539c-49b5-9ef4-d4ffa37d22e0')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureSecureCommunicationProtocolsTls11OrTls12OnWindowsServers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '828ba269-bf7f-4082-83dd-633417bc391d')
        parameters: {
          IncludeArcMachines: {
            value: true
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureSynapseWorkspaceDedicatedSqlMinimumTlsVersion'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '8b5c654c-fb07-471b-aa8f-15fea733f140')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToUseTheLatestTlsVersion'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'ae44c1d1-0df2-4ca9-98fa-a3d3ae5b409d')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppSlotsToUseTheLatestTlsVersion'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'fa3a6357-c6d6-4120-8429-855577ec0063')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToOnlyBeAccessibleOverHttps'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '0f98368e-36bc-4716-8ac2-8f8067203b63')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppsToOnlyBeAccessibleOverHttps'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a096cbd0-4693-432f-9374-682f485f23f3')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppSlotsToOnlyBeAccessibleOverHttps'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a18c77f2-3d6d-497a-9f61-849a7e8a3b79')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureSecureTransferOfDataOnAStorageAccount'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'f81e3117-0093-4b17-8a60-82363134f0eb')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
