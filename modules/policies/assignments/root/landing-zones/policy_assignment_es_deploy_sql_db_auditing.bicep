targetScope = 'managementGroup'

resource Deploy_SQL_DB_Auditing 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-SQL-DB-Auditing'
  properties: {
    description: 'Auditing on your SQL Server should be enabled to track database activities across all databases on the server and save them in an audit log.'
    displayName: 'Auditing on SQL server should be enabled'
    notScopes: []
    parameters: {
      effect: {
        value: 'AuditIfNotExists'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a6fb4358-5bf4-4ad7-ba82-2cd2f41ce5e9')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}
