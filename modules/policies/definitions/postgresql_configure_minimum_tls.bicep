targetScope = 'managementGroup'

resource PostgreSQL_Configure_Minimum_TLS 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'PostgreSQL-Configure-Minimum-TLS'
  properties: {
    displayName: 'Configure Azure Database for PostgreSQL to use the latest TLS version'
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
            equals: 'Microsoft.DBforPostgreSQL/servers'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.DBforPostgreSQL/servers/minimalTlsVersion'
                exists: false
              }
              {
                field: 'Microsoft.DBforPostgreSQL/servers/minimalTlsVersion'
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
            field: 'Microsoft.DBforPostgreSQL/servers/minimalTlsVersion'
            value: 'TLS1_2'
          }
        ]
      }
    }
  }
}
