targetScope = 'managementGroup'
resource MySQL_Configure_Disable_Public_Network_Access 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'MySQL-Configure-Disable-Public-Network-Access'
  properties: {
    displayName: 'Configure Azure Database for MySQL to disable public network access'
    description: 'Disables the public network access for Azure Database for MySQL.'
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
                field: 'Microsoft.DBforMySQL/servers/publicNetworkAccess'
                exists: false
              }
              {
                field: 'Microsoft.DBforMySQL/servers/publicNetworkAccess'
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
            field: 'Microsoft.DBforMySQL/servers/publicNetworkAccess'
            value: 'Disabled'
          }
        ]
      }
    }
  }
}
