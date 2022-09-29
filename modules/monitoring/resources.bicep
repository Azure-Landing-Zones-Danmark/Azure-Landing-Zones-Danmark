param location string = resourceGroup().location
param storageAccountName string
param logAnalyticsWorkspaceName string

module storageAccount '../shared/storage-account.bicep' = {
  name: 'storage-account-${uniqueString(resourceGroup().name, storageAccountName)}'
  params: {
    location: location
    storageAccountName: storageAccountName
    skuName: 'Standard_RAGRS'
  }
}

module logAnalyticsWorkspace '../shared/log-analytics-workspace.bicep' = {
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

module solution '../shared/log-analytics-workspace-solution.bicep' = [for solution in solutions: {
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
