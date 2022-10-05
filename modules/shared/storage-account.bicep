param location string = resourceGroup().location
param storageAccountName string
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param skuName string = 'Standard_LRS'
@allowed([
  'Hot'
  'Cool'
])
param accessTier string = 'Hot'
param allowSharedKeyAccess bool = true
param allowBlobPublicAccess bool = false
param isHnsEnabled bool = false
param isNfsV3Enabled bool = false
@allowed([
  'Disabled'
  'Enabled'
])
param largeFileSharesState string = 'Disabled'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: skuName
  }
  properties: {
    accessTier: accessTier
    allowBlobPublicAccess: allowBlobPublicAccess
    isHnsEnabled: isHnsEnabled
    isNfsV3Enabled: isNfsV3Enabled
    largeFileSharesState: largeFileSharesState
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowSharedKeyAccess: allowSharedKeyAccess
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
  }
}

output id string = storageAccount.id
