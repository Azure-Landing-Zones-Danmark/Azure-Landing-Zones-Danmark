targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param logAnalytics string

module Deploy_AzActivity_Log '../modules/policy-and-role-assignment.bicep' = {
  name: 'Deploy-AzActivity-Log-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deploy-AzActivity-Log'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '2465583e-4e78-4c15-b6be-a36cbc7c8b0f')
    location: location
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
      logAnalytics: {
        value: logAnalytics
      }
    }
  }
}
