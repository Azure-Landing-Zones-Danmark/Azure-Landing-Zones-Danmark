targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string

module Deny_Subnet_Without_Nsg '../../shared/policy-assignment.bicep' = {
  name: 'Deny-Subnet-Without-Nsg-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deny-Subnet-Without-Nsg'
    policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deny-Subnet-Without-Nsg')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
