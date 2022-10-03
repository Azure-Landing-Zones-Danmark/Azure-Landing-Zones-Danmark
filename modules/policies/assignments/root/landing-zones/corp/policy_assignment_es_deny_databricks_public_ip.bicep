targetScope = 'managementGroup'
resource Deny_DataB_Pip 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-DataB-Pip'
  properties: {
    description: 'Prevent the deployment of Databricks workspaces that do not use the noPublicIp feature to host Databricks clusters without public IPs.'
    displayName: 'Prevent usage of Databricks with public IP'
    notScopes: []
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'Deny-Databricks-NoPublicIp')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}