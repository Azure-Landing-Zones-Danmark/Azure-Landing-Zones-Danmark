targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param logAnalytics string

module Deploy_VM_Monitoring '../modules/policy-and-role-assignment.bicep' = {
  name: 'Deploy-VM-Monitoring-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deploy-VM-Monitoring'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '55f3eceb-5573-4f18-9695-226972c6d74a')
    location: location
    parameters: {
      logAnalytics_1: {
        value: logAnalytics
      }
    }
  }
}
