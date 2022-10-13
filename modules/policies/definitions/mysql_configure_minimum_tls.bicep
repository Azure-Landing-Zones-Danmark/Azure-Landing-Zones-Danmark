targetScope = 'managementGroup'
resource MySQL_Configure_Minimum_TLS 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'MySQL-Configure-Minimum-TLS'
  properties: {
    displayName: 'Configure Azure Database for MySQL to use the latest TLS version'
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
            equals: 'Microsoft.DBforMySQL/servers'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.DBforMySQL/servers/minimalTlsVersion'
                exists: false
              }
              {
                field: 'Microsoft.DBforMySQL/servers/minimalTlsVersion'
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
            field: 'Microsoft.DBforMySQL/servers/minimalTlsVersion'
            value: 'TLS1_2'
          }
        ]
      }
    }
  }
}
