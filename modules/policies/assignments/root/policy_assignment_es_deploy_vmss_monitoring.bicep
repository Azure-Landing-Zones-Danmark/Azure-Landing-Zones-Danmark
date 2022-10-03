targetScope = 'managementGroup'
param location string = deployment().location
param logAnalytics string

resource Deploy_VMSS_Monitoring 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-VMSS-Monitoring'
  properties: {
    description: 'Enable Azure Monitor for the Virtual Machine Scale Sets in the specified scope (Management group, Subscription or resource group). Takes Log Analytics workspace as parameter. Note: if your scale set upgradePolicy is set to Manual, you need to apply the extension to the all VMs in the set by calling upgrade on them. In CLI this would be az vmss update-instances.'
    displayName: 'Enable Azure Monitor for Virtual Machine Scale Sets'
    notScopes: []
    parameters: {
      logAnalytics_1: {
        value: logAnalytics
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policySetDefinitions', '75714362-cae7-409e-9b99-a8e5075b7fad')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}


// role assignments

// "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293" # Log Analytics Contributor
// "/providers/microsoft.authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c" // Virtual Machine Contributor
