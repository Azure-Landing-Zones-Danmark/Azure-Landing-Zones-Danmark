targetScope = 'managementGroup'

param managementGroupId string = 'root'
param location string = deployment().location
param logAnalyticsWorkspace string

module AzurePlatformConfiguration '../../initiative-and-role-assignment.bicep' = {
  name: 'AzurePlatformConfigurationAssignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'b63cdbcf84e94e819cb04967'
    policySetDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policySetDefinitions/AzurePlatformConfiguration'
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa'
      '/providers/Microsoft.Authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293'
    ]
    parameters: {
      logAnalyticsWorkspace: {
        value: logAnalyticsWorkspace
      }
    }
  }
}
