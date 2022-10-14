targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param root string

module Deny_Public_Endpoints '../.././../../shared/policy-assignment.bicep' = {
  name: 'Deny-Public-Endpoints-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deny-Public-Endpoints'
    policyDefinitionId: extensionResourceId(resourceId('Microsoft.Management/managementGroups', root), 'Microsoft.Authorization/policySetDefinitions', 'Deny-PublicPaaSEndpoints')
    parameters: {}
  }
}
