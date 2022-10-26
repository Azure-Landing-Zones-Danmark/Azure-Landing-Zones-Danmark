targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedIdentity string

module Guest_Attestation '../../shared/policy-assignment.bicep' = {
  name: 'Guest-Attestation-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Guest-Attestation'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '281d9e47-d14d-4f05-b8eb-18f2c4a034ff')
    userAssignedIdentity: userAssignedIdentity
    parameters: {}
  }
}
