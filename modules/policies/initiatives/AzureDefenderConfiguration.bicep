targetScope = 'managementGroup'

resource AzureDefenderConfiguration 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'AzureDefenderConfiguration'
  properties: {
    displayName: 'Azure Defender configuration'
    description: 'Azure Defender configuration'
    metadata: {
      version: '1.0.0'
      category: 'Security Center'
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
      exportToLogAnalyticsWorkspaceResourceGroupLocation : {
        type: 'String'
      }
      exportToLogAnalyticsWorkspaceResourceGroupName: {
        type: 'String'
      }
    }
    policyDefinitionGroups: []
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForAppServiceToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForResourceManagerToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/b7021b2b-08fd-4dc0-9de7-3c6ece09faf9'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureMicrosoftDefenderForContainersToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/c9ddb292-b203-4738-aead-18e2716e858f'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureMicrosoftDefenderForAzureCosmosDBToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/82bf5b87-728b-4a74-ba4d-6123845cf542'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForDNSToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/2370a3c1-4a25-4283-a91a-c9c1a145fb2f'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForKeyVaultsToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/1f725891-01c0-420a-9059-4fa46cb770b7'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForOpenSourceRelationalDatabasesToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/44433aa3-7ec2-4002-93ea-65c65ff0310a'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForAzureSQLDatabaseToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/b99b73e7-074b-4089-9395-b7236f094491'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForSQLServersOnMachinesToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/50ea7265-7d8c-429e-9a7d-ca1f410191c3'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderToBeEnabledOnSQLManagedInstances'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/c5a62eb0-c65a-4220-8a4d-f70dd4ca95dd'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForStorageToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/74c30959-af11-47b3-9ed2-a26e03f427a3'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDefenderForServersToBeEnabled'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/8e86a5b6-b9bd-49d1-8e21-4bb8a0862222'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'EnableSecurityCentersAutoProvisioningOfTheLogAnalyticsAgentOnYourSubscriptionsWithCustomWorkspace'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/8e7da0a5-0a0e-4bbc-bfc0-7773c018b616'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'DeployExportToLogAnalyticsWorkspaceForAzureSecurityCenterData'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/ffb6f416-7bd2-4488-8828-56585fef2be9'
        parameters: {
          resourceGroupName: {
            value: '[parameters(\'exportToLogAnalyticsWorkspaceResourceGroupName\')]'
          }
          resourceGroupLocation: {
            value: '[parameters(\'exportToLogAnalyticsWorkspaceResourceGroupLocation\')]'
          }
          workspaceResourceId: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureMachinesToReceiveAVulnerabilityAssessmentProvider'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/13ce0167-8ca6-4048-8e6b-f996402e3c1b'
        parameters: {
          vaType: {
            value: 'mdeTvm'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'DeployTheLinuxGuestConfigurationExtensionToEnableGuestConfigurationAssignmentsOnLinuxVms'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/331e8ea8-378a-410f-a2e5-ae22f38bb0da'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'DeployTheWindowsGuestConfigurationExtensionToEnableGuestConfigurationAssignmentsOnWindowsVms'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/385f5831-96d4-41db-9a3c-cd3af78aaae6'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureLogAnalyticsExtensionOnAzureArcEnabledLinuxServers'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/9d2b61b4-1d14-4a63-be30-d4498e7ad2cf'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureLogAnalyticsExtensionOnAzureArcEnabledWindowsServers'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/69af7d4a-7b18-4044-93a9-2651498ef203'
        parameters: {
          logAnalytics: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'AddSystemAssignedManagedIdentityToEnableGuestConfigurationAssignmentsOnVirtualMachinesWithNoIdentities'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/3cf2ab00-13f1-4d0c-8971-2ac904541a7e'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'AddSystemAssignedManagedIdentityToEnableGuestConfigurationAssignmentsOnVmsWithAUserAssignedIdentity'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/497dff13-db2a-4c0f-8603-28fa3b331ab6'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureKubernetesServiceClustersToEnableDefenderProfile'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/64def556-fbad-4622-930e-72d1d5589bf5'
        parameters: {
          logAnalyticsWorkspaceResourceId: {
            value: '[parameters(\'logAnalyticsWorkspace\')]'
          }
        }
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureArcEnabledKubernetesClustersToInstallAzureDefendersExtension'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/708b60a6-d253-4fe0-9114-4be4c00f012c'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'DeployAzurePolicyAddOnToAzureKubernetesServiceClusters'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a8eff44f-8c92-45c3-a3fb-9880802d67a7'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureArcEnabledKubernetesClustersToInstallTheAzurePolicyExtension'
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/0adc5395-9169-4b9b-8687-af838d69410a'
        parameters: {}
      }
    ]
  }
}
