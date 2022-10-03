targetScope = 'managementGroup'
param location string = deployment().location
param emailSecurityContact string
param logAnalytics string
param exportResourceGroupName string

resource Deploy_MDFC_Config 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-MDFC-Config'
  properties: {
    description: 'Deploy Microsoft Defender for Cloud configuration and Security Contacts'
    displayName: 'Deploy Microsoft Defender for Cloud configuration'
    notScopes: []
    parameters: {
      emailSecurityContact: {
        value: emailSecurityContact
      }
      logAnalytics: {
        value: logAnalytics
      }
      ascExportResourceGroupName: {
        value: exportResourceGroupName
      }
      ascExportResourceGroupLocation: {
        value: location
      }
      enableAscForServers: {
        value: 'DeployIfNotExists'
      }
      enableAscForSql: {
        value: 'DeployIfNotExists'
      }
      enableAscForAppServices: {
        value: 'DeployIfNotExists'
      }
      enableAscForStorage: {
        value: 'DeployIfNotExists'
      }
      enableAscForContainers: {
        value: 'DeployIfNotExists'
      }
      enableAscForKeyVault: {
        value: 'DeployIfNotExists'
      }
      enableAscForSqlOnVm: {
        value: 'DeployIfNotExists'
      }
      enableAscForArm: {
        value: 'DeployIfNotExists'
      }
      enableAscForDns: {
        value: 'DeployIfNotExists'
      }
      enableAscForOssDb: {
        value: 'DeployIfNotExists'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'Deploy-MDFC-Config')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// role assignments

// fb1c8493-542b-48eb-b624-b4c8fea62acd // Security Admin
// b24988ac-6180-42a0-ab88-20f7382dd24c // Contributor
