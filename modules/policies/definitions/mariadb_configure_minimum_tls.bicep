targetScope = 'managementGroup'
resource MariaDB_Configure_Minimum_TLS 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'MariaDB-Configure-Minimum-TLS'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Configure Azure Database for MariaDB to use the latest TLS version'
    description: 'Upgrade to the latest TLS version.'
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
                field: 'Microsoft.DBforMariaDB/servers/minimalTlsVersion'
                exists: false
              }
              {
                field: 'Microsoft.DBforMariaDB/servers/minimalTlsVersion'
                notEquals: 'TLS1_2'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: [
          {
            field: 'Microsoft.DBforMariaDB/servers/minimalTlsVersion'
            value: 'TLS1_2'
          }
        ]
      }
    }
  }
}
