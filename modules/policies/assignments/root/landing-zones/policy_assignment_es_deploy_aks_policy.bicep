targetScope = 'managementGroup'
param location string = deployment().location

resource Deploy_AKS_Policy 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-AKS-Policy'
  properties: {
    description: 'Use Azure Policy Add-on to manage and report on the compliance state of your Azure Kubernetes Service (AKS) clusters. For more information, see https://aka.ms/akspolicydoc.'
    displayName: 'Deploy Azure Policy Add-on to Azure Kubernetes Service clusters'
    notScopes: []
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a8eff44f-8c92-45c3-a3fb-9880802d67a7')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// roles

// "/providers/Microsoft.Authorization/roleDefinitions/ed7f3fbd-7b88-4dd4-9017-9adb7ce333f8", // Azure Kubernetes Service Contributor Role
// "/providers/Microsoft.Authorization/roleDefinitions/18ed5180-3e48-46fd-8541-4ea054d57064" // Azure Kubernetes Service Policy Add-on Deployment
