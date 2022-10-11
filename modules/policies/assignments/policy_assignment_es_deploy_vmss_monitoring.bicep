targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedManagedIdentity string
param logAnalytics string

module Deploy_VMSS_Monitoring '../../shared/policy-assignment.bicep' = {
  name: 'Deploy-VMSS-Monitoring-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-VMSS-Monitoring'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '75714362-cae7-409e-9b99-a8e5075b7fad')
    userAssignedManagedIdentity: userAssignedManagedIdentity
    parameters: {
      logAnalytics_1: {
        value: logAnalytics
      }
    }
  }
}
