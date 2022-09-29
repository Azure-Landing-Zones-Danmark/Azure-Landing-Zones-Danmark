targetScope = 'managementGroup'

param managementGroupId string = 'landing-zones'
param location string = deployment().location
param logAnalyticsWorkspace string

module AzureDiagnosticsConfiguration '../../../../../modules/policies/initiative-and-role-assignment.bicep' = {
  name: 'AzureDiagnosticsConfiguration'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'c435e80a0a924c36932558d0'
    policySetDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policySetDefinitions/AzureDiagnosticsConfiguration'
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

module AzureDiagnosticsConfigurationRoleAssignment '../../../../../modules/monitoring/log-analytics-workspace-role-assignment.bicep' = {
  name: 'AzureDiagnosticsConfigurationRoleAssignment'
  scope: resourceGroup(split(logAnalyticsWorkspace, '/')[2], split(logAnalyticsWorkspace, '/')[4])
  params: {
    principalId: AzureDiagnosticsConfiguration.outputs.managedIdentityId
    principalType: 'ServicePrincipal'
    roleName: 'Log Analytics Contributor'
    logAnalyticsWorkspaceName: last(split(logAnalyticsWorkspace, '/'))
  }
}
