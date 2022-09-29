targetScope = 'managementGroup'

resource AzurePlatformConfiguration 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'AzurePlatformConfiguration'
  properties: {
    displayName: 'Azure Platform Configuration'
    description: 'Azure Platform Configuration'
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
        policyDefinitionReferenceId: 'ConfigureAzureActivityLogsToStreamToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/2465583e-4e78-4c15-b6be-a36cbc7c8b0f'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
    ]
  }
}
