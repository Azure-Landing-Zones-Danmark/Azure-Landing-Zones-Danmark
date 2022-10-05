targetScope = 'managementGroup'

param managementGroupId string

module Deploy_SQL_DB_Auditing '../../modules/policy-assignment.bicep' = {
  name: 'Deploy-SQL-DB-Auditing-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deploy-SQL-DB-Auditing'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a6fb4358-5bf4-4ad7-ba82-2cd2f41ce5e9')
    parameters: {
      effect: {
        value: 'AuditIfNotExists'
      }
    }
  }
}
