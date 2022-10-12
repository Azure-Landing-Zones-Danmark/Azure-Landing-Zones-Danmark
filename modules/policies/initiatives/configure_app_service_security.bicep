targetScope = 'managementGroup'

resource Configure_App_Service_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-App-Service-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure security settings for App Services'
    description: 'This policy initiative is a group of policies that configures security settings App Services'
    metadata: {}
    parameters: {}
    policyDefinitions: [
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
        policyDefinitionReferenceId: 'Configure App Service app slots to disable FTP and FTPS'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service_App-Slots-Configure-Disable-FTPS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure App Service app slots to use the latest HTTP version'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-App-Slots-Configure-Latest-HTTP-Version')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure App Service app slots to use the latest TLS version for SCM sites'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-App-Slots-Configure-Latest-TLS-Version-For-SCM-Sites')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure App Service apps to disable FTP and FTPS'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App_Service_Apps_Configure_Disable_FTPS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure App Service apps to use the latest HTTP version'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-Apps-Configure-Latest-HTTP-Version')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure App Service apps to use the latest TLS version for SCM sites'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'App-Service-Apps-Configure-Latest-TLS-Version-For-SCM-Sites')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure Function app slots to disable FTP and FTPS'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function_App-Slots-Configure-Disable-FTPS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure Function app slots to use the latest HTTP version'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function-App-Slots-Configure-Latest-HTTP-Version')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure Function app slots to use the latest TLS version for SCM sites'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function-App-Slots-Configure-Latest-TLS-Version-For-SCM-Sites')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure Function apps to disable FTP and FTPS'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function_Apps_Configure_Disable_FTPS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure Function apps to use the latest HTTP version'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function-Apps-Configure-Latest-HTTP-Version')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'Configure Function apps to use the latest TLS version for SCM sites'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Function-Apps-Configure-Latest-TLS-Version-For-SCM-Sites')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
