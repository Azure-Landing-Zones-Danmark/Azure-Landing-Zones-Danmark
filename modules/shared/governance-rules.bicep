targetScope = 'subscription'

param disableManagerEmailNotification bool = false
param disableOwnerEmailNotification bool = false
param description string
param displayName string
param isDisabled bool = false
param isGracePeriod bool = true
param ownerSourceType string
param ownerSourceValue string
param remediationTimeFrame string = '7.00:00:00' //default 7 days
param rulePriority int
param ruleType string = 'Integrated'
param sourceResourceType string = 'Assessments' 

resource governanceRules 'Microsoft.Security/governanceRules@2022-01-01-preview' = {
  name: displayName
  properties: {
    conditionSets: [
      {
        conditions: [
            {
                value: [
                          'Low'
                          'Medium'
                          'High'
                        ]
                property: 'properties.metadata.severity'
                operator: 'In'
            }
        ]
    }
    ]
    description: description
    displayName: displayName
    governanceEmailNotification: {
      disableManagerEmailNotification: disableManagerEmailNotification
      disableOwnerEmailNotification: disableOwnerEmailNotification
    }
    isDisabled: isDisabled
    isGracePeriod: isGracePeriod
    ownerSource: {
      type: ownerSourceType
      value: ownerSourceValue
    }
    remediationTimeframe: remediationTimeFrame
    rulePriority: rulePriority
    ruleType: ruleType
    sourceResourceType: sourceResourceType
  }
}
