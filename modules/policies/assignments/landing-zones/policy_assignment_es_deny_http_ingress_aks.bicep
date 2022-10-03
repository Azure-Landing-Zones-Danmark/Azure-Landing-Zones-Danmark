targetScope = 'managementGroup'

param managementGroupId string

module Enforce_AKS_HTTPS '../../modules/policy-assignment.bicep' = {
  name: 'Enforce-AKS-HTTPS-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Enforce-AKS-HTTPS'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
