targetScope = 'managementGroup'

param managementGroupId string

module Deny_Storage_http '../modules/policy-assignment.bicep' = {
  name: 'Deny-Storage-http-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-Storage-http'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '404c3081-a854-4457-ae30-26a93ef643f9')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
