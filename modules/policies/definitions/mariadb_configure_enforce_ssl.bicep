targetScope = 'managementGroup'

resource MariaDB_Configure_Enforce_SSL 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'MariaDB-Configure-Enforce-SSL'
  properties: {
    displayName: 'Configure Azure Database for MariaDB to enforce SSL'
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'Enforces SSL for Azure Database for MariaDB.'
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
            equals: 'Microsoft.DBforMariaDB/servers/sslEnforcement'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.DBforMariaDB/servers/sslEnforcement'
                exists: 'false'
              }
              {
                field: 'Microsoft.DBforMariaDB/servers/sslEnforcement'
                notEquals: 'Enabled'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
          ]
          conflictEffect: 'audit'
          operations: [
            {
              operation: 'addOrReplace'
              field: 'Microsoft.DBforMariaDB/servers/sslEnforcement'
              value: 'Enabled'
            }
          ]
        }
      }
    }
  }
}
