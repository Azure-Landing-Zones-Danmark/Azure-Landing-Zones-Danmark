targetScope = 'managementGroup'
param location string = deployment().location

resource Deploy_LX_Arc_Monitoring 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-LX-Arc-Monitoring'
  properties: {
    description: 'Deploy-Linux-Arc-Monitoring.'
    displayName: 'Deploy-Linux-Arc-Monitoring'
    notScopes: []
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
      logAnalytics: {
        value: '/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/\${parTopLevelManagementGroupPrefix}-mgmt/providers/Microsoft.OperationalInsights/workspaces/\${parTopLevelManagementGroupPrefix}-la'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '9d2b61b4-1d14-4a63-be30-d4498e7ad2cf')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// role assignments

// "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293" # Log Analytics Contributor
