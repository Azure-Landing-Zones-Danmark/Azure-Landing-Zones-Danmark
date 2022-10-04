targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param emailSecurityContact string
param logAnalytics string
param exportResourceGroupName string

module Deploy_MDFC_Config '../modules/initiative-and-role-assignment.bicep' = {
  name: 'Deploy-MDFC-Config-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-MDFC-Config'
    policySetDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policySetDefinitions', 'Deploy-MDFC-Config')
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/fb1c8493-542b-48eb-b624-b4c8fea62acd'
      '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
    ]
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
  }
}
