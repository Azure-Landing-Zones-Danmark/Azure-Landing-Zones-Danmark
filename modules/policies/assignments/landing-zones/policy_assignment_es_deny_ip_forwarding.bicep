targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string

module Deny_IP_Forwarding '../.././../shared/policy-assignment.bicep' = {
  name: 'Deny-IP-Forwarding-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deny-IP-Forwarding'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '88c0b9da-ce96-4b03-9635-f29a937e2900')
    parameters: {}
  }
}
