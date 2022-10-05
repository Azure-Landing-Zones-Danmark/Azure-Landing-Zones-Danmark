param location string = resourceGroup().location
param ddosPlanName string

resource ddosProtectionPlan 'Microsoft.Network/ddosProtectionPlans@2022-05-01' = {
  name: ddosPlanName
  location: location
  properties: {}
}

output id string = ddosProtectionPlan.id
