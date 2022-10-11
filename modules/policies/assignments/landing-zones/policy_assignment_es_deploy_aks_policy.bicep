targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedManagedIdentity string

module Deploy_AKS_Policy '../.././../shared/policy-assignment.bicep' = {
  name: 'Deploy-AKS-Policy-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-AKS-Policy'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a8eff44f-8c92-45c3-a3fb-9880802d67a7')
    userAssignedManagedIdentity: userAssignedManagedIdentity
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
    }
  }
}
