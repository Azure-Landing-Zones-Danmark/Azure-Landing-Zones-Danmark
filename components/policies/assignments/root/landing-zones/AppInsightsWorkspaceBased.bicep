targetScope = 'managementGroup'

param managementGroupId string = 'landing-zones'
param logAnalyticsWorkspace string

module AppInsightsWorkspaceBased '../../../../../modules/policies/policy-assignment.bicep' = {
  name: 'AppInsightsWorkspaceBased'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'eae16d060f26406e819c177b'
    policyDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policyDefinitions/AppInsightsWorkspaceBased'
    parameters: {
      logAnalyticsWorkspace: {
        value: logAnalyticsWorkspace
      }
    }
  }
}
