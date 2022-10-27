targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param root string

module Deny_Public_IP '../.././../../shared/policy-assignment.bicep' = {
  name: 'Deny-Public-IP-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deny-Public-IP'
    policyDefinitionId: extensionResourceId(resourceId('Microsoft.Management/managementGroups', root), 'Microsoft.Authorization/policyDefinitions', 'Deny-PublicIP')
    parameters: {
      effect: {
        value: 'Deny'
      }
    }
  }
}
