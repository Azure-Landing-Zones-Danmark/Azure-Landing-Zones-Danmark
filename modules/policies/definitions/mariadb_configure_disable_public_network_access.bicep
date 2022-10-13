targetScope = 'managementGroup'
resource MariaDB_Configure_Disable_Public_Network_Access 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'MariaDB-Configure-Disable-Public-Network-Access'
  properties: {
    displayName: 'Configure Azure Database for MariaDB to disable public network access'
    description: 'Disables the public network access for Azure Database for MariaDB.'
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
                field: 'Microsoft.DBforMariaDB/servers/publicNetworkAccess'
                exists: false
              }
              {
                field: 'Microsoft.DBforMariaDB/servers/publicNetworkAccess'
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
            field: 'Microsoft.DBforMariaDB/servers/publicNetworkAccess'
            value: 'Disabled'
          }
        ]
      }
    }
  }
}
