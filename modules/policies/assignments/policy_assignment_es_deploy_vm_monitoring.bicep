targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param logAnalytics string

module Deploy_VM_Monitoring '../modules/initiative-and-role-assignment.bicep' = {
  name: 'Deploy-VM-Monitoring-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-VM-Monitoring'
    policySetDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '55f3eceb-5573-4f18-9695-226972c6d74a')
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293'
    ]
    parameters: {
      logAnalytics_1: {
        value: logAnalytics
      }
    }
  }
}
