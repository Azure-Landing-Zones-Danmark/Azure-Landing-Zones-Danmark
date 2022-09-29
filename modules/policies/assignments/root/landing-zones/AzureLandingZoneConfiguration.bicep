targetScope = 'managementGroup'

param managementGroupId string = 'landing-zones'
param location string = deployment().location

module AzureLandingZoneConfiguration '../../../modules/initiative-and-role-assignment.bicep' = {
  name: 'AzureLandingZoneConfiguration'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'bb19f19de01a475192980a09'
    policySetDefinitionId: '/providers/Microsoft.Management/managementGroups/root/providers/Microsoft.Authorization/policySetDefinitions/AzureLandingZoneConfiguration'
    roleDefinitionIds: [
      '/providers/Microsoft.Authorization/roleDefinitions/17d1049b-9a84-46fb-8f53-869881c3d3ab'
      '/providers/Microsoft.Authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
      '/providers/Microsoft.Authorization/roleDefinitions/de139f84-1756-47ae-9be6-808fbbe84772'
    ]
    parameters: {}
  }
}
