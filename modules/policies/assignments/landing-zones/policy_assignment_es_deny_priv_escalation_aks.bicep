targetScope = 'managementGroup'

param managementGroupId string

module Deny_Priv_Escalation_AKS '../../modules/policy-assignment.bicep' = {
  name: 'Deny-Priv-Escalation-AKS-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-Priv-Escalation-AKS'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '1c6e92c9-99f0-4e55-9cf2-0c234dc48f99')
    parameters: {
      effect: {
        value: 'deny'
      }
    }
  }
}
