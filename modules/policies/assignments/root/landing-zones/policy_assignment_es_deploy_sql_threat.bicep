targetScope = 'managementGroup'
param location string = deployment().location

resource Deploy_SQL_Threat 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-SQL-Threat'
  properties: {
    description: 'This policy ensures that Threat Detection is enabled on SQL Servers.'
    displayName: 'Deploy Threat Detection on SQL servers'
    notScopes: []
    parameters: {
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '36d49e87-48c4-4f2e-beed-ba4ed02b71f5')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// roles:
//  "/providers/microsoft.authorization/roleDefinitions/056cd41c-7e88-42e1-933e-88ba6a50c9c3"
