targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param logAnalytics string

module Deploy_Audit_AzActivity '../modules/policy-and-role-assignment.bicep' = {
  name: 'Deploy-Audit-AzActivity-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deploy-Audit-AzActivity'
    policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-Audit-LogAnalytics')
    location: location
    parameters: {
      logAnalytics: {
        value: logAnalytics
      }
    }
  }
}
