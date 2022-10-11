targetScope = 'managementGroup'
resource Deploy_Audit_LogAnalytics 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Deploy-Audit-LogAnalytics'
  properties: {
    policyType: 'Custom'
    displayName: 'Deploy Audit Settings to Azure Services'
    description: 'This policy set deploys the configurations of application Azure resources to forward Audit logs and metrics to an Azure Log Analytics workspace. See the list of policies of the services that are included '
    metadata: {
      version: '1.1.0'
      category: 'Monitoring'
    }
    parameters: {
      logAnalytics: {
        metadata: {
          description: 'Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant \'Log Analytics Contributor\' permissions (or similar) to the policy assignment\'s principal ID.'
          displayName: 'Log Analytics workspace'
          strongType: 'omsWorkspace'
        }
        type: 'String'
      }
      AuditAzActivityLogAssignmentEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Deploy Audit Settings for Storage Accounts to Log Analytics workspace'
          description: 'Deploys the audit settings for AzActivities to stream to a Log Analytics workspace when any resource which is missing this diagnostic settings is created or updated. The Policy will set the diagnostic with all metrics and category enabled'
        }
      }
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'AuditAzActivityLogAssignment'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '2465583e-4e78-4c15-b6be-a36cbc7c8b0f')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
          effect: {
            value: '[parameters(\'AuditAzActivityLogAssignmentEffect\')]'
          }
        }
        groupNames: []
      }
    ]
    policyDefinitionGroups: null
  }
}
