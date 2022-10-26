targetScope = 'managementGroup'

resource Configure_Cognitive_Services_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-Cognitive-Services-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure security settings for Cognitive Services'
    description: 'This policy initiative is a group of policies that configures security settings for Cognitive Services.'
    metadata: {
      version: '1.0'
      category: 'Kubernetes'
    }
    parameters: {}
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureAzureCognitiveSearchServicesToDisableLocalAuthentication'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '4eb216f2-9dba-4979-86e6-5d7e63ce3b75')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureCognitiveSearchServicesToDisablePublicNetworkAccess'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '9cee519f-d9c1-4fd9-9f79-24ec3449ed30')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureCognitiveServicesAccountsToDisableLocalAuthenticationMethods'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '14de9e63-1b31-492e-a5a3-c3f7fd57f555')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureCognitiveServicesAccountsToDisablePublicNetworkAccess'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '47ba1dd7-28d9-4b07-a8d5-9813bed64e0c')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
