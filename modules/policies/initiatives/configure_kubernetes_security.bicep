targetScope = 'managementGroup'

resource Configure_Kubernetes_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-Kubernetes-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure security settings for Azure Kubernetes Service'
    description: 'This policy initiative is a group of policies that configures security settings Azure Kubernetes Service.'
    metadata: {
      version: '1.0'
      category: 'Kubernetes'
    }
    parameters: {
      logAnalytics: {
        type: 'String'
        metadata: {
          displayName: 'Primary Log Analytics workspace'
          description: 'Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant \'Log Analytics Contributor\' permissions (or similar) to the policy assignment\'s principal ID.'
          strongType: 'omsWorkspace'
        }
      }
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureAzureArcEnabledKubernetesClustersToInstallMicrosoftDefenderForCloudExtension'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '708b60a6-d253-4fe0-9114-4be4c00f012c')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureArcEnabledKubernetesClustersToInstallTheAzurePolicyExtension'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '0adc5395-9169-4b9b-8687-af838d69410a')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployAzurePolicyAddOnToAzureKubernetesServiceClusters'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a8eff44f-8c92-45c3-a3fb-9880802d67a7')
        parameters: {}
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
        policyDefinitionReferenceId: 'ConfigureAzureKubernetesServiceClustersToEnableDefenderProfile'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '64def556-fbad-4622-930e-72d1d5589bf5')
        parameters: {
          logAnalyticsWorkspaceResourceId: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
