targetScope = 'managementGroup'

resource AzureDiagnosticsConfiguration 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'AzureDiagnosticsConfiguration'
  properties: {
    displayName: 'Azure Diagnostics configuration'
    description: 'Azure Diagnostics configuration'
    metadata: {
      version: '1.0.0'
      category: 'Monitoring'
    }
    parameters: {
      logAnalyticsWorkspace: {
        type: 'String'
        metadata: {
          displayName: 'Log Analytics Workspace'
          description: 'Select Log Analytics Workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant \'Log Analytics Contributor\' permissions (or similar) to the policy assignment\'s principal ID.'
          strongType: 'Microsoft.OperationalInsights/workspaces'
          assignPermissions: true
        }
      }
    }
    policyDefinitionGroups: []
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForStorageAccountToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/6f8f98a4-f108-47cb-8e98-91a0d85cd474'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          diagnosticsSettingNameToUse: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForAzureKubernetesServiceToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/6c66c325-74c8-42fd-a286-a74b0e2939d8'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          diagnosticsSettingNameToUse: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForBatchAccountToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/c84e5349-db6d-4769-805e-e14037dab9b5'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForDataLakeAnalyticsToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/d56a5a7c-72d7-42bc-8ceb-3baf4c0eae03'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForEventHubToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/1f6e93e8-6b31-41b1-83f6-36e449a42579'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForKeyVaultToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForLogicAppToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/b889a06c-ec72-4b03-910a-cb169ee18721'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForPublicIpAddresseToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/752154a7-1e0f-45c6-a880-ac75a7e4f648'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }

      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForRecoveryServicesVaultToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/c717fb0c-d118-4c43-ab3d-ece30ac81fb3'
        parameters: {
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForSearchServicesToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/08ba64b8-738f-4918-9686-730d2ed79c7d'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForServiceBusToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/04d53d87-841c-4f23-8a5b-21564380b55e'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForSqlDatabaseToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/b79fa14e-238a-4c2d-b376-442ce508fc84'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          diagnosticsSettingNameToUse: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureDiagnosticSettingsForStreamAnalyticsToLogAnalyticsWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/237e0f7e-b0e8-4ec4-ad46-8c12cb66d673'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          profileName: {
            value: 'SetByPolicy'
          }
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
    ]
  }
}
