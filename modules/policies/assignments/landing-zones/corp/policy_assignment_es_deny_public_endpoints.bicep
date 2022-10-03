targetScope = 'managementGroup'

param managementGroupId string

module Deny_Public_Endpoints '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-Public-Endpoints-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-Public-Endpoints'
    policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'Deny-PublicPaaSEndpoints')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
