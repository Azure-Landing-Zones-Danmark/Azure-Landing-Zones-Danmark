targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param logAnalytics string

module Deploy_VMSS_Monitoring '../modules/policy-and-role-assignment.bicep' = {
  name: 'Deploy-VMSS-Monitoring-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deploy-VMSS-Monitoring'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '75714362-cae7-409e-9b99-a8e5075b7fad')
    location: location
    parameters: {
      logAnalytics_1: {
        value: logAnalytics
      }
    }
  }
}
