targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedManagedIdentity string

module Enforce_TLS_SSL '../../shared/policy-assignment.bicep' = {
  name: 'Enforce-TLS-SSL-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Enforce-TLS-SSL'
    policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policySetDefinitions', 'Enforce-EncryptTransit')
    userAssignedManagedIdentity: userAssignedManagedIdentity
    parameters: {}
  }
}
