targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param logAnalytics string

module Deploy_VMSS_Monitoring '../modules/initiative-and-role-assignment.bicep' = {
  name: 'Deploy-VMSS-Monitoring-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-VMSS-Monitoring'
    policySetDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '75714362-cae7-409e-9b99-a8e5075b7fad')
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293'
      '/providers/microsoft.authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c'
    ]
    parameters: {
      logAnalytics_1: {
        value: logAnalytics
      }
    }
  }
}
