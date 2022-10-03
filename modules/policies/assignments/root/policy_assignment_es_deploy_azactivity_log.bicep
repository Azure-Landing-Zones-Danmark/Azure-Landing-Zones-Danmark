targetScope = 'managementGroup'
param location string = deployment().location
param logAnalytics string

resource Deploy_AzActivity_Log 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-AzActivity-Log'
  properties: {
    description: 'Ensures that Activity Log Diagnostics settings are set to push logs into Log Analytics workspace.'
    displayName: 'Deploy Diagnostic Settings for Activity Log to Log Analytics workspace'
    notScopes: []
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
      logAnalytics: {
        value: logAnalytics
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '2465583e-4e78-4c15-b6be-a36cbc7c8b0f')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// role assignments

// "/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", # Monitoring Contributor
// "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293" # Log Analytics Contributor
