param workspaceName string
@allowed([
  'Log Analytics Contributor'
  'Log Analytics Reader'
])
param roleName string
param principalId string
@allowed([
  'ForeignGroup'
  'Group'
  'ServicePrincipal'
  'User'
])
param principalType string

var roles = {
  'Log Analytics Reader': '73c42c96-874c-492b-b04d-ab87d138a893'
  'Log Analytics Contributor': '92aaf0da-9dab-42b6-94a3-d43ce8d16293'
}

var roleDefinitionId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roles[roleName])

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' existing = {
  name: workspaceName
}

resource logAnalyticsWorkspaceRoleAssignments 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  scope: logAnalyticsWorkspace
  name: guid(principalId, roleDefinitionId, logAnalyticsWorkspace.id)
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: principalId
    principalType: principalType
  }
}
