targetScope = 'managementGroup'
resource Deny_DataB_Sku 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-DataB-Sku'
  properties: {
    description: 'Enforces the use of Premium Databricks workspaces to make sure appropriate security features are available including Databricks Access Controls, Credential Passthrough and SCIM provisioning for AAD.'
    displayName: 'Enforces the use of Premium Databricks workspaces'
    notScopes: []
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-Sku')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}