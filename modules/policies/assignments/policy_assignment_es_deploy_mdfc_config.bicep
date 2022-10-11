targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedManagedIdentity string
param emailSecurityContact string
param logAnalytics string
param exportResourceGroupName string

module Deploy_MDFC_Config '../../shared/policy-assignment.bicep' = {
  name: 'Deploy-MDFC-Config-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-MDFC-Config'
    policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policySetDefinitions', 'Deploy-MDFC-Config')
    userAssignedManagedIdentity: userAssignedManagedIdentity
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
