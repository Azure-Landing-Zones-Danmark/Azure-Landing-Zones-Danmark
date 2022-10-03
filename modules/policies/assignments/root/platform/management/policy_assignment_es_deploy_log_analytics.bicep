targetScope = 'managementGroup'
param location string = deployment().location
param resourceGroupName string = 'Monitoring'
param workspaceName string
param automationAccountName string
param dataRetention int

resource Deploy_Log_Analytics 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-Log-Analytics'
  properties: {
    description: 'Deploy-Log-Analytics.'
    displayName: 'Deploy-Log-Analytics'
    notScopes: []
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
      workspaceName: {
        value: workspaceName
      }
      automationAccountName: {
        value: automationAccountName
      }
      workspaceRegion: {
        value: location
      }
      automationRegion: {
        value: location
      }
      dataRetention: {
        value: string(dataRetention)
      }
      sku: {
        value: 'pergb2018'
      }
      rgName: {
        value: resourceGroupName
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '8e3e61b3-0b32-22d5-4edf-55f87fdb5955')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// roles

// "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
