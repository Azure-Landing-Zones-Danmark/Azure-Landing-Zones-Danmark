param location string = resourceGroup().location
param automationAccountName string
@allowed([
  'Basic'
  'Free'
])
param skuName string = 'Free'

resource automationAccount 'Microsoft.Automation/automationAccounts@2022-08-08' = {
  name: automationAccountName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    disableLocalAuth: true
    publicNetworkAccess: true
    sku: {
      name: skuName
    }
  }
}

output id string = automationAccount.id
