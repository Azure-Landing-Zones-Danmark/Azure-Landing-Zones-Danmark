targetScope = 'managementGroup'

param managementGroupId string

module Deny_DataB_Vnet '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-DataB-Vnet-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-DataB-Vnet'
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-VirtualNetwork')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
