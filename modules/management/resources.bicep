targetScope = 'managementGroup'

param location string = deployment().location
param managementSubscriptionId string
param resourceGroupName string
param automationAccountName string
param ddosPlanName string
param storageAccountName string
param userAssignedIdentityName string
param workspaceName string

module group '../shared/resource-group.bicep' = {
  scope: subscription(managementSubscriptionId)
  name: 'resource-group-${uniqueString(resourceGroupName)}'
  params: {
    location: location
    resourceGroupName: resourceGroupName
  }
}

module automationAccount '../shared/automation-account.bicep' = {
  scope: resourceGroup(managementSubscriptionId,resourceGroupName)
  name: 'automation-account-${uniqueString(resourceGroupName, automationAccountName)}'
  dependsOn: [
    group
  ]
  params: {
    location: location
    automationAccountName: storageAccountName
    skuName: 'Basic'
  }
}

module ddosProtectionPlan '../shared/ddos-protection-plan.bicep' = if (false) {
  scope: resourceGroup(managementSubscriptionId,resourceGroupName)
  name: 'ddos-protection-plan-${uniqueString(resourceGroupName, ddosPlanName)}'
  dependsOn: [
    group
  ]
  params: {
    location: location
    ddosPlanName: ddosPlanName
  }
}

module storageAccount '../shared/storage-account.bicep' = {
  scope: resourceGroup(managementSubscriptionId,resourceGroupName)
  name: 'storage-account-${uniqueString(resourceGroupName, storageAccountName)}'
  dependsOn: [
    group
  ]
  params: {
    location: location
    storageAccountName: storageAccountName
    skuName: 'Standard_RAGRS'
  }
}

module userAssignedIdentity '../shared/user-assigned-identity.bicep' = {
  scope: resourceGroup(managementSubscriptionId,resourceGroupName)
  name: 'user-assigned-identity-${uniqueString(resourceGroupName, userAssignedIdentityName)}'
  dependsOn: [
    group
  ]
  params: {
    location: location
    identityName: userAssignedIdentityName
  }
}

module userAssignedIdentityRoleAssignment '../shared/management-group-role-assignment.bicep' = {
  name: 'management-group-role-assignment-${uniqueString(managementGroup().id, userAssignedIdentityName)}'
  dependsOn: [
    userAssignedIdentity
  ]
  params: {
    principalId: userAssignedIdentity.outputs.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: '/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
  }
}

module workspace '../shared/log-analytics-workspace.bicep' = {
  scope: resourceGroup(managementSubscriptionId,resourceGroupName)
  name: 'log-analytics-workspace-${uniqueString(resourceGroupName, workspaceName)}'
  dependsOn: [
    group
  ]
  params: {
    location: location
    workspaceName: workspaceName
  }
}

var solutions = [
  'AgentHealthAssessment'
  'AzureActivity'
  'ChangeTracking'
  'Security'
  'SecurityInsights'
  'ServiceMap'
  'SQLAdvancedThreatProtection'
  'SQLAssessment'
  'SQLVulnerabilityAssessment'
  'Updates'
  'VMInsights'
]

module solution '../shared/log-analytics-workspace-solution.bicep' = [for solution in solutions: {
  scope: resourceGroup(managementSubscriptionId,resourceGroupName)
  name: 'log-analytics-workspace-solution-${uniqueString(resourceGroupName, workspaceName, solution)}'
  dependsOn: [
    workspace
  ]
  params: {
    location: location
    logAnalyticsWorkspaceName: workspaceName
    solutionName: solution
  }
}]
