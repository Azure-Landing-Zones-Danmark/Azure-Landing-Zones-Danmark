targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedManagedIdentity string
param logAnalytics string

module Deploy_AzActivity_Log '../../shared/policy-assignment.bicep' = {
  name: 'Deploy-AzActivity-Log-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-AzActivity-Log'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '2465583e-4e78-4c15-b6be-a36cbc7c8b0f')
    userAssignedManagedIdentity: userAssignedManagedIdentity
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
