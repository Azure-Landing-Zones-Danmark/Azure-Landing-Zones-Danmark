targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string

module Deploy_ASC_Monitoring '../../shared/policy-assignment.bicep' = {
  name: 'Deploy-ASC-Monitoring-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-ASC-Monitoring'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '1f3afdf9-d0c9-4c3d-847f-89da613e70a8')
    parameters: {}
  }
}
