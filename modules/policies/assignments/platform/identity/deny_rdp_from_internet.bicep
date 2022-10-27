targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param root string

module Deny_RDP_From_Internet '../../../../shared/policy-assignment.bicep' = {
  name: 'Deny-RDP-From-Internet-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deny-RDP-From-Internet'
    policyDefinitionId: extensionResourceId(resourceId('Microsoft.Management/managementGroups', root), 'Microsoft.Authorization/policyDefinitions', 'Deny-RDP-From-Internet')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
