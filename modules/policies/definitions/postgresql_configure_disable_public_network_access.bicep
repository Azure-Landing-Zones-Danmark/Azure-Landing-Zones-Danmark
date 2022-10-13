targetScope = 'managementGroup'

resource PostgreSQL_Configure_Disable_Public_Network_Access 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'PostgreSQL-Configure-Disable-Public-Network-Access'
  properties: {
    displayName: 'Configure Azure Database for PostgreSQL to disable public network access'
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'Disables the public network access for Azure Database for PostgreSQL.'
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
            equals: 'Microsoft.DBforPostgreSQL/servers/publicNetworkAccess'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.DBforPostgreSQL/servers/publicNetworkAccess'
                exists: 'false'
              }
              {
                field: 'Microsoft.DBforPostgreSQL/servers/publicNetworkAccess'
                notEquals: 'Disabled'
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
              field: 'Microsoft.DBforPostgreSQL/servers/publicNetworkAccess'
              value: 'Disabled'
            }
          ]
        }
      }
    }
  }
}
