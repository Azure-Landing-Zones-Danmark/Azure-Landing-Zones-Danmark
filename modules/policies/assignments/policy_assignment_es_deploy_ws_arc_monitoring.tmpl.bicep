targetScope = 'managementGroup'
param location string = deployment().location

resource Deploy_WS_Arc_Monitoring 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-WS-Arc-Monitoring'
  properties: {
    description: 'Deploys the Log Analytics agent to Windows Azure Arc machines if the agent isn\'t installed.'
    displayName: 'Deploy-Windows-Arc-Monitoring'
    notScopes: []
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
      logAnalytics: {
        value: '/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/\${parTopLevelManagementGroupPrefix}-mgmt/providers/Microsoft.OperationalInsights/workspaces/\${parTopLevelManagementGroupPrefix}-la'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '69af7d4a-7b18-4044-93a9-2651498ef203')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}