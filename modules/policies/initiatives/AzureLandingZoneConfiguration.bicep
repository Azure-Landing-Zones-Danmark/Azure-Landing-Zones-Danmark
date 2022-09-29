targetScope = 'managementGroup'

resource AzureLandingZoneConfiguration 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'AzureLandingZoneConfiguration'
  properties: {
    displayName: 'Azure Landing Zone Configuration'
    description: 'Azure Landing Zone Configuration'
    metadata: {
      version: '1.0.0'
      category: 'Security Center'
    }
    policyDefinitionGroups: []
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'AppServiceAppendHttpsOnly'
        policyDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policyDefinitions/AppServiceAppendHttpsOnly'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'AppServiceDeploymentSlotsAppendHttpsOnly'
        policyDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policyDefinitions/AppServiceDeploymentSlotsAppendHttpsOnly'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'AppServiceDeploymentSlotsDeploySecurityControls'
        policyDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policyDefinitions/AppServiceDeploymentSlotsDeploySecurityControls'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'AppServiceDeploySecurityControls'
        policyDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policyDefinitions/AppServiceDeploySecurityControls'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'KeyVaultModifySecurityControls'
        policyDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policyDefinitions/KeyVaultModifySecurityControls'
        parameters: {}
      }
      {
        policyDefinitionReferenceId: 'StorageAccountModifySecurityControls'
        policyDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policyDefinitions/StorageAccountModifySecurityControls'
        parameters: {}
      }
    ]
  }
}
