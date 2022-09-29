targetScope = 'managementGroup'
resource Deny_Databricks_VirtualNetwork 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-Databricks-VirtualNetwork'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Deny Databricks workspaces without Vnet injection'
    description: 'Enforces the use of vnet injection for Databricks workspaces.'
    metadata: {
      version: '1.0.0'
      category: 'Databricks'
    }
    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'Audit'
          'Disabled'
          'Deny'
        ]
        defaultValue: 'Deny'
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Databricks/workspaces'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.DataBricks/workspaces/parameters.customVirtualNetworkId.value'
                exists: false
              }
              {
                field: 'Microsoft.DataBricks/workspaces/parameters.customPublicSubnetName.value'
                exists: false
              }
              {
                field: 'Microsoft.DataBricks/workspaces/parameters.customPrivateSubnetName.value'
                exists: false
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}