targetScope = 'managementGroup'

resource KubernetesConfiguration 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'KubernetesConfiguration'
  properties: {
    displayName: 'Kubernetes Configuration'
    description: 'Kubernetes Configuration'
    metadata: {
      version: '1.0.0'
      category: 'Monitoring'
    }
    parameters: {
      logAnalyticsWorkspace: {
        type: 'String'
        metadata: {
          displayName: 'Log Analytics Workspace'
          description: 'Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant \'Log Analytics Contributor\' permissions (or similar) to the policy assignment\'s principal ID.'
          strongType: 'Microsoft.OperationalInsights/workspaces'
          assignPermissions: true
        }
      }
    }
    policyDefinitionGroups: []
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'AksEnableMonitoring'
        policyDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policyDefinitions/AksEnableMonitoring'
        parameters: {
          logAnalyticsWorkspace: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
    ]
  }
}
