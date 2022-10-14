targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedManagedIdentity string

module Deploy_SQL_Threat '../../shared/policy-assignment.bicep' = {
  name: 'Deploy-SQL-Threat-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-SQL-Threat'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '36d49e87-48c4-4f2e-beed-ba4ed02b71f5')
    userAssignedManagedIdentity: userAssignedManagedIdentity
    parameters: {}
  }
}
