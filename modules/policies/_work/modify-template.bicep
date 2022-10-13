targetScope = 'managementGroup'
resource ResourceType_Configure_Property 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'ResourceType-Configure-Property'
  properties: {
    displayName: 'Configure ResourceType to Property'
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'Disable FTP and FTPS'
    metadata: {
      version: '1.0'
      category: 'Category'
    }
    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'Modify'
          'Disabled'
        ]
        defaultValue: 'Modify'
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Web/sites'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.Web/sites/httpsOnly'
                exists: false
              }
              {
                field: 'Microsoft.Web/sites/httpsOnly'
                equals: 'false'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/ROLE_ID'
          ]
          conflictEffect: 'audit'
          operations: [
            {
              operation: 'addOrReplace'
              field: 'Microsoft.Web/sites/httpsOnly'
              value: true
            }
          ]
        }
      }
    }
  }
}
