targetScope = 'managementGroup'

resource Configure_App_Service_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-App-Service-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure security settings for App Services'
    description: 'This policy initiative is a group of policies that configures security settings App Services.'
    metadata: {
      version: '1.0'
      category: 'App Service'
    }
    parameters: {}
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToUseTheLatestTlsVersion'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'ae44c1d1-0df2-4ca9-98fa-a3d3ae5b409d')
        parameters: {}
        groupNames: []
      }
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
        policyDefinitionReferenceId: 'ConfigureFunctionAppSlotsToUseTheLatestTlsVersion'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'fa3a6357-c6d6-4120-8429-855577ec0063')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppSlotsToDisableLocalAuthenticationForScmSites'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '2c034a29-2a5f-4857-b120-f800fe5549ae')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToDisableLocalAuthenticationForFtpDeployments'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '572e342c-c920-4ef5-be2e-1ed3c6a51dc5')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToDisableLocalAuthenticationForScmSites'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '5e97b776-f380-4722-a9a3-e7f0be029e79')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppSlotsToDisableLocalAuthenticationForFtpDeployments'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'f493116f-3b7f-4ab3-bf80-0c2af35e46c2')
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
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToTurnOffRemoteDebugging'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a5e3fe8f-f6cd-4f1d-bbf6-c749754a724b')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToTurnOffRemoteDebugging'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'cca5adfe-626b-4cc6-8522-f5b6ed2391bd')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppsToTurnOffRemoteDebugging'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '25a5046c-c423-4805-9235-e844ae9ef49b')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppSlotsToTurnOffRemoteDebugging'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '70adbb40-e092-42d5-a6f8-71c540a5efdb')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppSlotsToDisableFtpAndFtps'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-App-Slots-Configure-Disable-FTPS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppSlotsToUseTheLatestHttpVersion'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-App-Slots-Configure-Latest-HTTP-Version')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppSlotsToUseTheLatestTlsVersionForScmSites'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-App-Slots-Configure-Latest-TLS-Version-For-SCM-Sites')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToDisableFtpAndFtps'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App_Service_Apps_Configure_Disable_FTPS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToUseTheLatestHttpVersion'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-Apps-Configure-Latest-HTTP-Version')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAppServiceAppsToUseTheLatestTlsVersionForScmSites'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-Apps-Configure-Latest-TLS-Version-For-SCM-Sites')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppSlotsToDisableFtpAndFtps'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function_App-Slots-Configure-Disable-FTPS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppSlotsToUseTheLatestHttpVersion'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function-App-Slots-Configure-Latest-HTTP-Version')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppSlotsToUseTheLatestTlsVersionForScmSites'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function-App-Slots-Configure-Latest-TLS-Version-For-SCM-Sites')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppsToDisableFtpAndFtps'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function_Apps_Configure_Disable_FTPS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppsToUseTheLatestHttpVersion'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function-Apps-Configure-Latest-HTTP-Version')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureFunctionAppsToUseTheLatestTlsVersionForScmSites'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function-Apps-Configure-Latest-TLS-Version-For-SCM-Sites')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}