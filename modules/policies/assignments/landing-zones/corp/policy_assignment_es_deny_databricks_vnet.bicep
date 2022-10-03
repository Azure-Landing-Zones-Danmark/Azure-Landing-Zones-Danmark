targetScope = 'managementGroup'

param managementGroupId string

module Deny_DataBricks_Vnet '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-DataBricks-Vnet-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-DataBricks-Vnet'
    policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-VirtualNetwork')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
