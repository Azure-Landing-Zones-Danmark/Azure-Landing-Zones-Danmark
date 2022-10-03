targetScope = 'managementGroup'
param location string = deployment().location
param logAnalytics string

resource Deploy_Resource_Diag 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-Resource-Diag'
  properties: {
    description: 'Ensures that Azure resources are configured to forward diagnostic logs and metrics to an Azure Log Analytics workspace.'
    displayName: 'Deploy-Resource-Diag'
    notScopes: []
    parameters: {
      logAnalytics: {
        value: logAnalytics
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'Deploy-Diagnostics-LogAnalytics')
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
