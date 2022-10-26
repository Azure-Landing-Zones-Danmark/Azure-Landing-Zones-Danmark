targetScope = 'managementGroup'

resource Azure_SQL_Configure_Latest_TLS_Version 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Azure-SQL-Configure-Latest-TLS-Version'
  properties: {
    displayName: 'Configure Azure SQL Database to use the latest TLS version'
    description: 'Upgrade to the latest TLS version.'
    policyType: 'Custom'
    mode: 'Indexed'
    metadata: {
      version: '1.0'
      category: 'SQL'
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
            equals: 'Microsoft.Sql/servers'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.Sql/servers/minimalTlsVersion'
                exists: false
              }
              {
                field: 'Microsoft.Sql/servers/minimalTlsVersion'
                notEquals: '1.2'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/6d8ee4ec-f05a-4a1d-8b00-a9b17e38b437'
          ]
          conflictEffect: 'audit'
          operations: [
            {
              operation: 'addOrReplace'
              field: 'Microsoft.Sql/servers/minimalTlsVersion'
              value: '1.2'
            }
          ]
        }
      }
    }
  }
}