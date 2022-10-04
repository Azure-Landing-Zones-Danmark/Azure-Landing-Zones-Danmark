targetScope = 'managementGroup'

param managementGroupId string
param root string

module Deny_Public_IP '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-Public-IP-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-Public-IP'
    policyDefinitionId: extensionResourceId(root, 'Microsoft.Authorization/policyDefinitions', 'Deny-PublicIP')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
