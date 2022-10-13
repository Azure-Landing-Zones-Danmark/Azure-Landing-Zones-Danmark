targetScope = 'managementGroup'
resource Deny_PublicPaaSEndpoints 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Deny-PublicPaaSEndpoints'
  properties: {
    policyType: 'Custom'
    displayName: 'Public network access should be disabled for PaaS services'
    description: 'This policy initiative is a group of policies that prevents creation of Azure PaaS services with exposed public endpoints'
    metadata: {
    }
    parameters: {
      CosmosPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access should be disabled for CosmosDB'
          description: 'This policy denies that  Cosmos database accounts  are created with out public network access is disabled.'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      KeyVaultPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access should be disabled for KeyVault'
          description: 'This policy denies creation of Key Vaults with IP Firewall exposed to all public endpoints'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      SqlServerPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access on Azure SQL Database should be disabled'
          description: 'This policy denies creation of Sql servers with exposed public endpoints'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      StoragePublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access onStorage accounts should be disabled'
          description: 'This policy denies creation of storage accounts with IP Firewall exposed to all public endpoints'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      AKSPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access on AKS API should be disabled'
          description: 'This policy denies  the creation of  Azure Kubernetes Service non-private clusters'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      ACRPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access on Azure Container Registry disabled'
          description: 'This policy denies the creation of Azure Container Registires with exposed public endpoints '
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      AFSPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access on Azure File Sync disabled'
          description: 'This policy denies the creation of Azure File Sync instances with exposed public endpoints '
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      PostgreSQLFlexPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access should be disabled for PostgreSql Flexible Server'
          description: 'This policy denies creation of Postgre SQL Flexible DB accounts with exposed public endpoints'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      MySQLFlexPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access should be disabled for MySQL Flexible Server'
          description: 'This policy denies creation of MySql Flexible Server DB accounts with exposed public endpoints'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      BatchPublicIpDenyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Public network access should be disabled for Azure Batch Instances'
          description: 'This policy denies creation of Azure Batch Instances with exposed public endpoints'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'CosmosDenyPaasPublicIP'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '797b37f7-06b8-444c-b1ad-fc62867f335a')
        parameters: {
          effect: {
            value: '[parameters(\'CosmosPublicIpDenyEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'AKSDenyPaasPublicIP'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '040732e8-d947-40b8-95d6-854c95024bf8')
        parameters: {
          effect: {
            value: '[parameters(\'AKSPublicIpDenyEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ACRDenyPaasPublicIP'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '0fdf0491-d080-4575-b627-ad0e843cba0f')
        parameters: {
          effect: {
            value: '[parameters(\'ACRPublicIpDenyEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'AFSDenyPaasPublicIP'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '21a8cd35-125e-4d13-b82d-2e19b7208bb7')
        parameters: {
          effect: {
            value: '[parameters(\'AFSPublicIpDenyEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'PostgreSQLFlexDenyPublicIP'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '5e1de0e3-42cb-4ebc-a86d-61d0c619ca48')
        parameters: {
          effect: {
            value: '[parameters(\'PostgreSQLFlexPublicIpDenyEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'MySQLFlexDenyPublicIP'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'c9299215-ae47-4f50-9c54-8a392f68a052')
        parameters: {
          effect: {
            value: '[parameters(\'MySQLFlexPublicIpDenyEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'BatchDenyPublicIP'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '74c5a0ae-5e48-4738-b093-65e23a060488')
        parameters: {
          effect: {
            value: '[parameters(\'BatchPublicIpDenyEffect\')]'
          }
        }
        groupNames: []
      }
    ]
    policyDefinitionGroups: null
  }
}
