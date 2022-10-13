targetScope = 'managementGroup'

resource Azure_SQL_Managed_Instance_Configure_Latest_TLS_Version 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Azure-SQL-Managed-Instance-Configure-Latest-TLS-Version'
  properties: {
    displayName: 'Configure Azure SQL Managed Instance to use the latest TLS version'
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
            equals: 'Microsoft.Sql/managedInstances'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.Sql/managedInstances/minimalTlsVersion'
                exists: false
              }
              {
                field: 'Microsoft.Sql/managedInstances/minimalTlsVersion'
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
            field: 'Microsoft.Sql/managedInstances/minimalTlsVersion'
            value: '1.2'
          }
        ]
      }
    }
  }
}
