targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param root string

module Deny_DataBricks_Pip '../.././../../shared/policy-assignment.bicep' = {
  name: 'Deny-DataBricks-Pip-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deny-DataBricks-Pip'
    policyDefinitionId: extensionResourceId(resourceId('Microsoft.Management/managementGroups', root), 'Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-NoPublicIp')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
