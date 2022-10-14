targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedManagedIdentity string
param logAnalytics string

module Deploy_Resource_Diag '../../shared/policy-assignment.bicep' = {
  name: 'Deploy-Resource-Diag-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-Resource-Diag'
    policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policySetDefinitions', 'Deploy-Diagnostics-LogAnalytics')
    userAssignedManagedIdentity: userAssignedManagedIdentity
    parameters: {
      logAnalytics: {
        value: logAnalytics
      }
    }
  }
}
