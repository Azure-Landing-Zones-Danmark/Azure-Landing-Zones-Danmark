targetScope = 'managementGroup'

param managementGroupId string = 'root'
param location string = deployment().location
param logAnalyticsWorkspace string

module AzureDefenderConfiguration '../../initiative-and-role-assignment.bicep' = {
  name: 'AzureDefenderConfigurationAssignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'ad988fed67d34deb9ce886bd'
    policySetDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policySetDefinitions/AzureDefenderConfiguration'
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/fb1c8493-542b-48eb-b624-b4c8fea62acd'
      '/providers/Microsoft.Authorization/roleDefinitions/056cd41c-7e88-42e1-933e-88ba6a50c9c3'
      '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
    ]
    parameters: {
      logAnalyticsWorkspace: {
        value: logAnalyticsWorkspace
      }
      exportToLogAnalyticsWorkspaceResourceGroupLocation: {
        value: location
      }
      exportToLogAnalyticsWorkspaceResourceGroupName: {
        value: 'AzurePlatform'
      }
    }
  }
}
