targetScope = 'managementGroup'

param managementGroupId string

module Deny_DataB_Pip '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-DataB-Pip-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-DataB-Pip'
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-NoPublicIp')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
