param location string = resourceGroup().location
param storageAccountName string
param logAnalyticsWorkspaceName string
param automationAccountName string

module storageAccount '../../modules/storage/storage-account.bicep' = {
  name: 'storage-account-${uniqueString(resourceGroup().name, storageAccountName)}'
  params: {
    location: location
    storageAccountName: storageAccountName
    skuName: 'Standard_RAGRS'
  }
}

module logAnalyticsWorkspace '../../modules/monitoring/log-analytics-workspace.bicep' = {
  name: 'log-analytics-${uniqueString(resourceGroup().name, logAnalyticsWorkspaceName)}'
  params: {
    location: location
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
  }
}

var solutions = [
  'Security'
  'SecurityCenterFree'
  'SQLAdvancedThreatProtection'
  'SQLVulnerabilityAssessment'
]

module solution '../../modules/monitoring/solution.bicep' = [for solution in solutions: {
  name: 'solution-${solution}'
  dependsOn: [
    logAnalyticsWorkspace
  ]
  params: {
    location: location
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    solutionName: solution
  }
}]

module automationAccount '../../modules/monitoring/automation-account.bicep' = {
  name: 'automation-account-${automationAccountName}'
  params: {
    location: location
    automationAccountName: automationAccountName
  }
}
