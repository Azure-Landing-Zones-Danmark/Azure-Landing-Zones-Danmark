targetScope = 'managementGroup'
resource Deny_Public_Endpoints 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Public-Endpoints'
  properties: {
    description: 'This policy initiative is a group of policies that prevents creation of Azure PaaS services with exposed public endpoints.'
    displayName: 'Public network access should be disabled for PaaS services'
    notScopes: []
    parameters: {
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'Deny-PublicPaaSEndpoints')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}