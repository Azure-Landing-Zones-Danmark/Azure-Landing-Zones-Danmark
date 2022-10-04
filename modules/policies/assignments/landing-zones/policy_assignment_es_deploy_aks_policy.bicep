targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string

module Deploy_AKS_Policy '../../modules/policy-and-role-assignment.bicep' = {
  name: 'Deploy-AKS-Policy-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-AKS-Policy'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a8eff44f-8c92-45c3-a3fb-9880802d67a7')
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
    }
  }
}
