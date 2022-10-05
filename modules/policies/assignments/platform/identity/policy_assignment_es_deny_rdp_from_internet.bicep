targetScope = 'managementGroup'

param managementGroupId string
param root string

module Deny_RDP_From_Internet '../../../modules/policy-assignment.bicep' = {
  name: 'Deny-RDP-From-Internet-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    policyAssignmentName: 'Deny-RDP-From-Internet'
    policyDefinitionId: extensionResourceId(resourceId('Microsoft.Management/managementGroups', root), 'Microsoft.Authorization/policyDefinitions', 'Deny-RDP-From-Internet')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
