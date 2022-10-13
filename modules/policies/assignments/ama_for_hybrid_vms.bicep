targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedIdentity string
param logAnalytics string

module AMA_For_Hybrid_VMs '../../shared/policy-assignment.bicep' = {
  name: 'AMA-For-Hybrid-VMs-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'AMA-For-Hybrid-VMs'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '59e9c3eb-d8df-473b-8059-23fd38ddd0f0')
    userAssignedIdentity: userAssignedIdentity
    parameters: {
      logAnalyticsWorkspace: {
        value: logAnalytics
      }
    }
  }
}
