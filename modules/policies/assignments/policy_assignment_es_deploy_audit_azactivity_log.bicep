targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param logAnalytics string

module Deploy_AzActivity_Log '../modules/policy-and-role-assignment.bicep' = {
  name: 'Audit-AzActivity-Log-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Audit-AzActivity-Log'
    policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-Audit-LogAnalytics')
    location: location
    parameters: {
      logAnalytics: {
        value: logAnalytics
      }
    }
  }
}
