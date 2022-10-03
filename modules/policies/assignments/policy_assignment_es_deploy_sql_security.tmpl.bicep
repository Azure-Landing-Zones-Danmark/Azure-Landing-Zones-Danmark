targetScope = 'managementGroup'
param location string = deployment().location

resource Deploy_SQL_Security 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-SQL-Security'
  properties: {
    description: 'Deploy-SQL-Security.'
    displayName: 'Deploy-SQL-Security'
    notScopes: []
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '86a912f6-9a06-4e26-b447-11b16ba8659f')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}