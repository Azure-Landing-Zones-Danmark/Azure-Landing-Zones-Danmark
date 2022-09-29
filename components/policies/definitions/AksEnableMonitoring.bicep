targetScope = 'managementGroup'

resource AksEnableMonitoring 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'AksEnableMonitoring'
  properties: {
    displayName: 'Configure AKS monitoring addon'
    description: 'Configure AKS monitoring addon'
    mode: 'Indexed'
    metadata: {
      version: '1.0.0'
      category: 'Kubernetes'
    }
    parameters: {
      logAnalyticsWorkspace: {
        type: 'String'
        metadata: {
          displayName: 'Resource Id of the existing Azure Log Analytics Workspace'
          description: 'Azure Monitor Log Analytics Resource ID'
          strongType: 'Microsoft.OperationalInsights/workspaces'
          assignPermissions: true
        }
      }
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        defaultValue: 'DeployIfNotExists'
      }
    }
    policyRule: {
      if: {
        field: 'type'
        equals: 'Microsoft.ContainerService/managedClusters'
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          type: 'Microsoft.ContainerService/managedClusters'
          name: '[field(\'name\')]'
          roleDefinitionIds: [
            '/providers/Microsoft.Authorization/roleDefinitions/ed7f3fbd-7b88-4dd4-9017-9adb7ce333f8'
            '/providers/Microsoft.Authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293'
          ]
          existenceCondition: {
            field: 'Microsoft.ContainerService/managedClusters/addonProfiles.omsagent.enabled'
            equals: true
          }
          deployment: {
            properties: {
              mode: 'Incremental'
              template: {
                '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  clusterName: {
                    type: 'string'
                  }
                  clusterResourceGroupName: {
                    type: 'string'
                  }
                  clusterLocation: {
                    type: 'string'
                  }
                  logAnalyticsWorkspace: {
                    type: 'string'
                  }
                }
                resources: [
                  {
                    type: 'Microsoft.Resources/deployments'
                    name: '[Concat(\'aks-monitoring-policy\', \'-\', uniqueString(parameters(\'clusterName\')))]'
                    apiVersion: '2021-04-01'
                    properties: {
                      mode: 'Incremental'
                      template: {
                        '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
                        contentVersion: '1.0.0.0'
                        parameters: {}
                        variables: {}
                        resources: [
                          {
                            name: '[parameters(\'clusterName\')]'
                            type: 'Microsoft.ContainerService/managedClusters'
                            location: '[parameters(\'clusterLocation\')]'
                            apiVersion: '2022-07-01'
                            properties: {
                              mode: 'Incremental'
                              id: '[resourceId(parameters(\'clusterResourceGroupName\'), \'Microsoft.ContainerService/managedClusters\', parameters(\'clusterName\'))]'
                              addonProfiles: {
                                omsagent: {
                                  enabled: true
                                  config: {
                                    logAnalyticsWorkspaceResourceId: '[parameters(\'logAnalyticsWorkspace\')]'
                                  }
                                }
                              }
                            }
                          }
                        ]
                      }
                    }
                  }
                ]
              }
              parameters: {
                clusterName: {
                  value: '[field(\'name\')]'
                }
                clusterResourceGroupName: {
                  value: '[resourceGroup().name]'
                }
                clusterLocation: {
                  value: '[field(\'location\')]'
                }
                logAnalyticsWorkspace: {
                  value: '[parameters(\'logAnalyticsWorkspace\')]'
                }
              }
            }
          }
        }
      }
    }
  }
}
