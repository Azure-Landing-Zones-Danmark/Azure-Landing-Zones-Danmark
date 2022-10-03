targetScope = 'managementGroup'

param managementGroupId string

module Deny_Priv_Containers_AKS '../../modules/policy-assignment.bicep' = {
  name: 'Deny-Priv-Containers-AKS-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-Priv-Containers-AKS'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '95edb821-ddaf-4404-9732-666045e056b4')
    parameters: {
      effect: {
        value: 'deny'
      }
    }
  }
}
