targetScope = 'managementGroup'

param exemptionName string
param description string
param displayName string
param exemptionCategory string = 'Waiver'
param baseTime string = utcNow('u')
param expiresOn string =  dateTimeAdd(baseTime, 'P30D') //default 30 days
param policyAssignmentId string
param policyDefinitionReferenceIds array
param exemptionRequestor string
param exemptionApprover string
param exemptionJustification string

resource policyExemption 'Microsoft.Authorization/policyExemptions@2020-07-01-preview' = {
  name: exemptionName
  properties: {
    description: description
    displayName: displayName
    exemptionCategory: exemptionCategory
    expiresOn: expiresOn
    metadata: {
      requestor: exemptionRequestor
      approver: exemptionApprover
      Justification: exemptionJustification
    }
    policyAssignmentId: policyAssignmentId
    policyDefinitionReferenceIds: policyDefinitionReferenceIds
  }
}
