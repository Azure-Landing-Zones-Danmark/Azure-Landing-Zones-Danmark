targetScope = 'managementGroup'
param location string = deployment().location

resource Deploy_VM_Backup 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-VM-Backup'
  properties: {
    description: 'Enforce backup for all virtual machines by deploying a recovery services vault in the same location and resource group as the virtual machine. Doing this is useful when different application teams in your organization are allocated separate resource groups and need to manage their own backups and restores. You can optionally exclude virtual machines containing a specified tag to control the scope of assignment. See https://aka.ms/AzureVMAppCentricBackupExcludeTag.'
    displayName: 'Configure backup on virtual machines without a given tag to a new recovery services vault with a default policy'
    notScopes: []
    parameters: {
      effect: {
        value: 'deployIfNotExists'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '98d0b9f8-fd90-49c9-88e2-d3baf3b0dd86')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// roles
// "/providers/Microsoft.Authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c",
// "/providers/Microsoft.Authorization/roleDefinitions/5e467623-bb1f-42f4-a55d-6e525e11384b"
