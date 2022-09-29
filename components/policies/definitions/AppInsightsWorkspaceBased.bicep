targetScope = 'managementGroup'

resource AppInsightsWorkspaceBased 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'AppInsightsWorkspaceBased'
  properties: {
    displayName: 'Application Insights should use Workspace-based resource mode'
    description: 'Application Insights should use Workspace-based resource mode with central Log Analytics Workspace'
    mode: 'Indexed'
    metadata: {
      category: 'Monitoring'
    }
    parameters: {
      logAnalyticsWorkspace: {
        type: 'String'
        metadata: {
          displayName: 'Resource Id of the existing Azure Log Analytics Workspace'
          description: 'Azure Monitor Log Analytics Resource ID'
          strongType: 'Microsoft.OperationalInsights/workspaces'
        }
      }
      effectType: {
        type: 'String'
        defaultValue: 'Audit'
        allowedValues: [
          'Audit'
          'Disabled'
        ]
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Insights/components'
          }
          {
            not: {
              field: 'Microsoft.Insights/components/WorkspaceResourceId'
              equals: '[parameters(\'logAnalyticsWorkspace\')]'
            }
          }
        ]
      }
      then: {
        effect: '[parameters(\'effectType\')]'
      }
    }
  }
}
