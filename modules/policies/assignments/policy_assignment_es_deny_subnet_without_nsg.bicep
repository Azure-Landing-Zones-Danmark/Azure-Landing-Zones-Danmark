targetScope = 'managementGroup'

param managementGroupId string

module Deny_Subnet_Without_Nsg '../modules/policy-assignment.bicep' = {
  name: 'Deny-Subnet-Without-Nsg-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-Subnet-Without-Nsg'
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Subnet-Without-Nsg')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
