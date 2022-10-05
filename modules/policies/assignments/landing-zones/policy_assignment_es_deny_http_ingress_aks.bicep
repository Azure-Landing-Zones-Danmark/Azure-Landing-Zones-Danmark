targetScope = 'managementGroup'

param managementGroupId string

module Deny_Http_Ingress_AKS '../../modules/policy-assignment.bicep' = {
  name: 'Deny-Http-Ingress-AKS-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-Http-Ingress-AKS'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
