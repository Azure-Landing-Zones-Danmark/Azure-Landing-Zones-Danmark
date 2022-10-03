targetScope = 'managementGroup'
param location string = deployment().location

resource Deploy_Private_DNS_Zones 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deploy-Private-DNS-Zones'
  properties: {
    description: 'This policy initiative is a group of policies that ensures private endpoints to Azure PaaS services are integrated with Azure Private DNS zones.'
    displayName: 'Configure Azure PaaS services to use private DNS zones'
    notScopes: []
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
      azureFilePrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.afs.azure.net'
      }
      azureWebPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.webpubsub.azure.com'
      }
      azureBatchPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.\${parDefaultRegion}.batch.azure.com'
      }
      azureAppPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.azconfig.io'
      }
      azureAsrPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}\${parDefaultRegion}.privatelink.siterecovery.windowsazure.com'
      }
      azureIoTPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.azure-devices-provisioning.net'
      }
      azureKeyVaultPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.vaultcore.azure.net'
      }
      azureSignalRPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.service.signalr.net'
      }
      azureAppServicesPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.azurewebsites.net'
      }
      azureEventGridTopicsPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.eventgrid.azure.net'
      }
      azureDiskAccessPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.blob.core.windows.net'
      }
      azureCognitiveServicesPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.cognitiveservices.azure.com'
      }
      azureIotHubsPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.azure-devices.net'
      }
      azureEventGridDomainsPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.eventgrid.azure.net'
      }
      azureRedisCachePrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.redis.cache.windows.net'
      }
      azureAcrPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.azurecr.io'
      }
      azureEventHubNamespacePrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.servicebus.windows.net'
      }
      azureMachineLearningWorkspacePrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.api.azureml.ms'
      }
      azureServiceBusNamespacePrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.servicebus.windows.net'
      }
      azureCognitiveSearchPrivateDnsZoneId: {
        value: '\${private_dns_zone_prefix}privatelink.search.windows.net'
      }
    }
    policyDefinitionId: resourceId('Microsoft.Authorization/policySetDefinitions', 'Deploy-Private-DNS-Zones')
    enforcementMode: 'Default'
  }
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

// roles:
// "/providers/Microsoft.Authorization/roleDefinitions/b12aa53e-6015-4669-85d0-8515ebb3ae7f",
// "/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7"
// "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
