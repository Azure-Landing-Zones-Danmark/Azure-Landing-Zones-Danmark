targetScope = 'managementGroup'

param managementGroupId string
param root string

module Deny_DataBricks_Pip '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-DataBricks-Pip-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-DataBricks-Pip'
    policyDefinitionId: extensionResourceId(root, 'Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-NoPublicIp')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
