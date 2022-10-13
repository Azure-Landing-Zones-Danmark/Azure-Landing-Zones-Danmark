targetScope = 'managementGroup'
resource PostgreSQL_Flex_Configure_Disable_Public_Network_Access 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'PostgreSQL-Flex-Configure-Disable-Public-Network-Access'
  properties: {
    displayName: 'Configure Azure Database for PostgreSQL flexible server to disable public network access'
    description: 'Disables the public network access for Azure Database for PostgreSQL flexible server.'
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
            equals: 'Microsoft.DBforPostgreSQL/flexibleServers'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.DBforPostgreSQL/flexibleServers/publicNetworkAccess'
                exists: false
              }
              {
                field: 'Microsoft.DBforPostgreSQL/flexibleServers/publicNetworkAccess'
                notEquals: 'Disabled'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: [
          {
            field: 'Microsoft.DBforPostgreSQL/flexibleServers/publicNetworkAccess'
            value: 'Disabled'
          }
        ]
      }
    }
  }
}
