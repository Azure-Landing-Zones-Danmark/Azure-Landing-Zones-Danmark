targetScope = 'managementGroup'

resource Configure_Server_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-Server-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure server security'
    description: 'This policy initiative is a group of policies that configures server security.'
    metadata: {
      version: '1.0'
      category: 'Guest Configuration'
    }
    parameters: {}
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureSecureCommunicationProtocolsTls11OrTls12OnWindowsServers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '828ba269-bf7f-4082-83dd-633417bc391d')
        parameters: {
          IncludeArcMachines: {
            value: true
          }
        }
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
