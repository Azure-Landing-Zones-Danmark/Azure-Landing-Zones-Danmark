targetScope = 'managementGroup'
param location string = deployment().location
param logAnalytics string

resource Deploy_VM_Monitoring 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-VM-Monitoring'
  properties: {
    description: 'Enable Azure Monitor for the virtual machines (VMs) in the specified scope (management group, subscription or resource group). Takes Log Analytics workspace as parameter.'
    displayName: 'Enable Azure Monitor for VMs'
    notScopes: []
    parameters: {
      logAnalytics_1: {
        value: logAnalytics
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '55f3eceb-5573-4f18-9695-226972c6d74a')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// role assignments

// "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293" # Log Analytics Contributor
