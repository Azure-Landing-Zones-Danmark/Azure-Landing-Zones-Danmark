targetScope = 'managementGroup'

param managementGroupId string
param root string

module Deny_Public_Endpoints '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-Public-Endpoints-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-Public-Endpoints'
    policyDefinitionId: extensionResourceId(root, 'Microsoft.Authorization/policySetDefinitions', 'Deny-PublicPaaSEndpoints')
    parameters: {}
  }
}
