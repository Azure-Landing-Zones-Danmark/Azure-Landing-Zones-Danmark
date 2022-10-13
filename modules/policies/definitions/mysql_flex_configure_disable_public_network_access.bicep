targetScope = 'managementGroup'
resource MySQL_Flex_Configure_Disable_Public_Network_Access 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'MySQL-Flex-Configure-Disable-Public-Network-Access'
  properties: {
    displayName: 'Configure Azure Database for MySQL flexible server to disable public network access'
    description: 'Disables the public network access for Azure Database for MySQL flexible server.'
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
            equals: 'Microsoft.DBforMySQL/flexibleServers'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.DBforMySQL/flexibleServers/publicNetworkAccess'
                exists: false
              }
              {
                field: 'Microsoft.DBforMySQL/flexibleServers/publicNetworkAccess'
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
            field: 'Microsoft.DBforMySQL/flexibleServers/publicNetworkAccess'
            value: 'Disabled'
          }
        ]
      }
    }
  }
}
