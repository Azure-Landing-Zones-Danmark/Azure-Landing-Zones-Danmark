targetScope = 'managementGroup'

resource Configure_Monitoring 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-Monitoring'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure Diagnostic Settings for PaaS services to Log Analytics workspace'
    description: 'Deploys diagnostic settings.'
    metadata: {
      version: '1.0'
      category: 'Monitoring'
    }
    parameters: {
      logAnalytics: {
        type: 'String'
        metadata: {
          displayName: 'Log Analytics workspace'
          description: 'Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant \'Log Analytics Contributor\' permissions (or similar) to the policy assignment\'s principal ID.'
          strongType: 'omsWorkspace'
        }
      }
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureAzureActivityLogsToStreamToSpecifiedLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '2465583e-4e78-4c15-b6be-a36cbc7c8b0f')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployDiagnosticSettingsForBatchAccountToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'c84e5349-db6d-4769-805e-e14037dab9b5')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployConfigureDiagnosticSettingsForAzureKeyVaultToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '951af2fa-529b-416e-ab6e-066fd85ac459')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployConfigureDiagnosticSettingsForAzureKubernetesServiceToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '6c66c325-74c8-42fd-a286-a74b0e2939d8')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForStorageAccountsToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '59759c62-9a22-4cdf-ae64-074495983fef')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForBlobServicesToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'b4fe1a3b-0715-4c6c-a5ea-ffc33cf823cb')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForFileServicesToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '25a70cc8-2bd4-47f1-90b6-1478e4662c96')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForQueueServicesToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '7bd000e3-37c7-4928-9f31-86c4b77c5c45')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForTableServicesToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '2fb86bf3-d221-43d1-96d1-2434af34eaa0')
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
