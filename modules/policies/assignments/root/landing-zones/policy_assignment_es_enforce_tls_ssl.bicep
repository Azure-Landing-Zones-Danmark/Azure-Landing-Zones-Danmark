targetScope = 'managementGroup'
param location string = deployment().location

resource Enforce_TLS_SSL 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Enforce-TLS-SSL'
  properties: {
    description: 'Choose either Deploy if not exist and append in combination with audit or Select Deny in the Policy effect. Deny polices shift left. Deploy if not exist and append enforce but can be changed, and because missing exsistense condition require then the combination of Audit.'
    displayName: 'Deny or Deploy and append TLS requirements and SSL enforcement on resources without Encryption in transit'
    notScopes: []
    parameters: {
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'Enforce-EncryptTransit')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

resource Enforce_TLS_SSL_role_assignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: '061f9ff4-adf0-451c-bea5-e54e8fd6de3b' // to be dynamic
  properties: {
    principalId: Enforce_TLS_SSL.identity.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: tenantResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  }
}
