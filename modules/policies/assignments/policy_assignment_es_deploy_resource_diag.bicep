targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param logAnalytics string

module Deploy_Resource_Diag '../modules/initiative-and-role-assignment.bicep' = {
  name: 'Deploy-Resource-Diag-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-Resource-Diag'
    policySetDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policySetDefinitions', 'Deploy-Diagnostics-LogAnalytics')
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa'
      '/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293'
    ]
    parameters: {
      logAnalytics: {
        value: logAnalytics
      }
    }
  }
}
