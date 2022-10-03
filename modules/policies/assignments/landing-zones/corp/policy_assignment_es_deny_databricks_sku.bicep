targetScope = 'managementGroup'

param managementGroupId string

module Deny_DataB_Sku '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-DataB-Sku-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-DataB-Sku'
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-Sku')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
