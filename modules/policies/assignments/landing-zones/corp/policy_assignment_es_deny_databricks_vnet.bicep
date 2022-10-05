targetScope = 'managementGroup'

param managementGroupId string
param root string

module Deny_DataBricks_Vnet '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-DataBricks-Vnet-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-DataBricks-Vnet'
    policyDefinitionId: extensionResourceId(resourceId('Microsoft.Management/managementGroups', root), 'Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-VirtualNetwork')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
