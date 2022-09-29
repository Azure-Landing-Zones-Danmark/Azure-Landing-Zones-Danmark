targetScope = 'managementGroup'
resource Deny_Sql_minTLS 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-Sql-minTLS'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Azure SQL Database should have the minimal TLS version set to the highest version'
    description: 'Setting minimal TLS version to 1.2 improves security by ensuring your Azure SQL Database can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not reccomended since they have well documented security vunerabilities.'
    metadata: {
      version: '1.0.0'
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
          'Audit'
          'Disabled'
          'Deny'
        ]
        defaultValue: 'Audit'
      }
      minimalTlsVersion: {
        type: 'String'
        defaultValue: '1.2'
        allowedValues: [
          '1.2'
          '1.1'
          '1.0'
        ]
        metadata: {
          displayName: 'Select version for SQL server'
          description: 'Select version minimum TLS version SQL servers to enforce'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Sql/servers'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.Sql/servers/minimalTlsVersion'
                exists: 'false'
              }
              {
                field: 'Microsoft.Sql/servers/minimalTlsVersion'
                notequals: '[parameters(\'minimalTlsVersion\')]'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}