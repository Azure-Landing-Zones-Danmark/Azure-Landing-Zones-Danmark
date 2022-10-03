targetScope = 'managementGroup'
resource Deny_Storage_http 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Storage-http'
  properties: {
    description: 'Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking.'
    displayName: 'Secure transfer to storage accounts should be enabled'
    notScopes: []
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '404c3081-a854-4457-ae30-26a93ef643f9')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}