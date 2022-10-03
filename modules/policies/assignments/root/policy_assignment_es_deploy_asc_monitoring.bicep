targetScope = 'managementGroup'
resource Deploy_ASC_Monitoring 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-ASC-Monitoring'
  properties: {
    description: 'Enable Monitoring in Microsoft Defender for Cloud.'
    displayName: 'Enable Monitoring in Microsoft Defender for Cloud'
    notScopes: []
    parameters: {
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '1f3afdf9-d0c9-4c3d-847f-89da613e70a8')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}