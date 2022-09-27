targetScope = 'tenant'

param managementSubscriptionId string
param onlineSubscriptionIds array

var rootManagementGroupId = 'root'

resource tenantRoot 'Microsoft.Management/managementGroups@2021-04-01' existing = {
  name: tenant().tenantId
}

resource root 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: rootManagementGroupId
  properties: {
    displayName: 'Root'
    details: {
      parent: {
        id: tenantRoot.id
      }
    }
  }
}

resource management 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'management'
  properties: {
    displayName: 'Management'
    details: {
      parent: {
        id: root.id
      }
    }
  }

  resource subscription 'subscriptions' = {
    name: managementSubscriptionId
  }
}

resource landingZones 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'landing-zones'
  properties: {
    displayName: 'Landing Zones'
    details: {
      parent: {
        id: root.id
      }
    }
  }
}

resource online 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'online'
  properties: {
    displayName: 'Online'
    details: {
      parent: {
        id: landingZones.id
      }
    }
  }

  resource subscription 'subscriptions' = [for subscriptionId in onlineSubscriptionIds: {
    name: subscriptionId
  }]
}

resource corp 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'corp'
  properties: {
    displayName: 'Corp'
    details: {
      parent: {
        id: landingZones.id
      }
    }
  }
}
