targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param root string

module Deny_DataBricks_Vnet '../.././../../shared/policy-assignment.bicep' = {
  name: 'Deny-DataBricks-Vnet-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deny-DataBricks-Vnet'
    policyDefinitionId: extensionResourceId(resourceId('Microsoft.Management/managementGroups', root), 'Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-VirtualNetwork')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
