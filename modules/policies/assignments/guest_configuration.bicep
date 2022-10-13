targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string

module Guest_Configuration '../../shared/policy-assignment.bicep' = {
  name: 'Guest-Configuration-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Guest-Configuration'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '12794019-7a00-42cf-95c2-882eed337cc8')
    parameters: {}
  }
}
