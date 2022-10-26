targetScope = 'managementGroup'

resource Configure_Container_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-Container-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure security settings for containers'
    description: 'This policy initiative is a group of policies that configures security settings for containers.'
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
        policyDefinitionReferenceId: 'KubernetesClustersShouldBeAccessibleOnlyOverHttps'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d')
        parameters: {
          effect: {
            value: 'Deny'
          }
        }
        groupNames: []
      }
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
        policyDefinitionReferenceId: 'ConfigureAzureKubernetesServiceClustersToEnableDefenderProfile'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '64def556-fbad-4622-930e-72d1d5589bf5')
        parameters: {
          logAnalyticsWorkspaceResourceId: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureContainerRegistriesToDisableAnonymousAuthentication'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'cced2946-b08a-44fe-9fd9-e4ed8a779897')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureContainerRegistriesToDisableLocalAdminAccount'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '79fdfe03-ffcb-4e55-b4d0-b925b8241759')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'KubernetesClusterShouldNotAllowPrivilegedContainers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '95edb821-ddaf-4404-9732-666045e056b4')
        parameters: {
          effect: {
            value: 'Deny'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'KubernetesClustersShouldNotAllowContainerPrivilegeEscalation'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '1c6e92c9-99f0-4e55-9cf2-0c234dc48f99')
        parameters: {
          effect: {
            value: 'Deny'
          }
        }
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
