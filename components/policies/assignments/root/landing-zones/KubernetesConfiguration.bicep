targetScope = 'managementGroup'

param managementGroupId string = 'landing-zones'
param location string = deployment().location
param logAnalyticsWorkspace string

module KubernetesConfiguration '../../../../../modules/policies/initiative-and-role-assignment.bicep' = {
  name: 'KubernetesConfiguration'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'f3f7412de9a249d78462a27f'
    policySetDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policySetDefinitions/KubernetesConfiguration'
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/ed7f3fbd-7b88-4dd4-9017-9adb7ce333f8'
      '/providers/Microsoft.Authorization/roleDefinitions/18ed5180-3e48-46fd-8541-4ea054d57064'
      '/providers/Microsoft.Authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293'
      '/providers/Microsoft.Authorization/roleDefinitions/85cb6faf-e071-4c9b-8136-154b5a04f717'
      '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
    ]
    parameters: {
      logAnalyticsWorkspace: {
        value: logAnalyticsWorkspace
      }
    }
  }
}

module KubernetesConfigurationRoleAssignment '../../../../../modules/monitoring/log-analytics-workspace-role-assignment.bicep' = {
  name: 'KubernetesConfiguration'
  scope: resourceGroup(split(logAnalyticsWorkspace, '/')[2], split(logAnalyticsWorkspace, '/')[4])
  params: {
    principalId: KubernetesConfiguration.outputs.managedIdentityId
    principalType: 'ServicePrincipal'
    roleName: 'Log Analytics Contributor'
    logAnalyticsWorkspaceName: last(split(logAnalyticsWorkspace, '/'))
  }
}
