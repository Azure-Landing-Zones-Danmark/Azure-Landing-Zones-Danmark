targetScope = 'managementGroup'
param location string = deployment().location
param ddosPlan string

resource Enable_DDoS_VNET 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Enable-DDoS-VNET'
  properties: {
    description: 'Protect your virtual networks against volumetric and protocol attacks with Azure DDoS Protection Standard. For more information, visit https://aka.ms/ddosprotectiondocs.'
    displayName: 'Virtual networks should be protected by Azure DDoS Protection Standard'
    notScopes: []
    parameters: {
      effect: {
        value: 'Modify'
      }
      ddosPlan: {
        value: ddosPlan
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '94de2ad3-e0c1-4caf-ad78-5d47bbc83d3d')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// roles:
// "/providers/microsoft.authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"
