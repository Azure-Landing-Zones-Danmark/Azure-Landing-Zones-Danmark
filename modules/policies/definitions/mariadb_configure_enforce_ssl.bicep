targetScope = 'managementGroup'
resource MariaDB_Configure_Enforce_SSL 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'MariaDB-Configure-Enforce-SSL'
  properties: {
    displayName: 'Configure Azure Database for MariaDB to enforce SSL'
    description: 'Enforces SSL for Azure Database for MariaDB.'
    policyType: 'Custom'
    mode: 'Indexed'
    metadata: {
      version: '1.0'
      category: 'SQL'
    }
    parameters: {
      effect: {
        type: 'String'
        defaultValue: 'Append'
        allowedValues: [
          'Append'
          'Disabled'
        ]
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.DBforMariaDB/servers'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.DBforMariaDB/servers/sslEnforcement'
                exists: false
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
        details: [
          {
            field: 'Microsoft.DBforMariaDB/servers/sslEnforcement'
            value: 'Enabled'
          }
        ]
      }
    }
  }
}
