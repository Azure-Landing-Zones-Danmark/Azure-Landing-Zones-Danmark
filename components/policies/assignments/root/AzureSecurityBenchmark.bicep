targetScope = 'managementGroup'

param managementGroupId string = 'root'

module AzureSecurityBenchmark '../../../../modules/policies/policy-assignment.bicep' = {
  name: 'AzureSecurityBenchmarkAssignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'f65b68115b1f4eee95bd51d3'
    policyDefinitionId: '/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8'
    parameters: {}
  }
}
