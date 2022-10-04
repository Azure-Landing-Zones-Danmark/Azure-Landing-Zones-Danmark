targetScope = 'managementGroup'

param managementGroupId string
param root string

module Deny_DataBricks_Sku '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-DataBricks-Sku-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-DataBricks-Sku'
    policyDefinitionId: extensionResourceId(root, 'Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-Sku')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
