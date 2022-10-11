targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param root string

module Deny_DataBricks_Sku '../.././../../shared/policy-assignment.bicep' = {
  name: 'Deny-DataBricks-Sku-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deny-DataBricks-Sku'
    policyDefinitionId: extensionResourceId(resourceId('Microsoft.Management/managementGroups', root), 'Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-Sku')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
