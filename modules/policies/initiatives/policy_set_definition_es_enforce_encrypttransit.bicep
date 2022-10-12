targetScope = 'managementGroup'
resource Enforce_EncryptTransit 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Enforce-EncryptTransit'
  properties: {
    policyType: 'Custom'
    displayName: 'Deny or Deploy and append TLS requirements and SSL enforcement on resources without Encryption in transit'
    description: 'Choose either Deploy if not exist and append in combination with audit or Select Deny in the Policy effect. Deny polices shift left. Deploy if not exist and append enforce but can be changed, and because missing exsistense condition require then the combination of Audit. '
    metadata: {
      version: '1.0.0'
      category: 'Encryption'
    }
    parameters: {
      AKSIngressHttpsOnlyEffect: {
        metadata: {
          displayName: 'AKS Service. Enforce HTTPS ingress in Kubernetes cluster'
          description: 'This policy enforces HTTPS ingress in a Kubernetes cluster. This policy is generally available for Kubernetes Service (AKS), and preview for AKS Engine and Azure Arc enabled Kubernetes. For instructions on using this policy, visit https://aka.ms/kubepolicydoc.'
        }
        type: 'String'
        defaultValue: 'deny'
        allowedValues: [
          'audit'
          'deny'
          'disabled'
        ]
      }
      MySQLEnableSSLDeployEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'MySQL database servers. Deploy if not exist set minimum TLS version Azure Database for MySQL server'
          description: 'Deploy a specific min TLS version requirement and enforce SSL on Azure Database for MySQL server. Enforce the Server to client applications using minimum version of Tls to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
        }
      }
      MySQLEnableSSLEffect: {
        metadata: {
          displayName: 'MySQL database servers. Enforce SSL connection should be enabled for MySQL database servers'
          description: 'Azure Database for MySQL supports connecting your Azure Database for MySQL server to client applications using Secure Sockets Layer (SSL). Enforcing SSL connections between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
        }
        type: 'String'
        defaultValue: 'Audit'
        allowedValues: [
          'Audit'
          'Disabled'
          'Deny'
        ]
      }
      MySQLminimalTlsVersion: {
        type: 'String'
        defaultValue: 'TLS1_2'
        allowedValues: [
          'TLS1_2'
          'TLS1_0'
          'TLS1_1'
          'TLSEnforcementDisabled'
        ]
        metadata: {
          displayName: 'MySQL database servers. Select version minimum TLS for MySQL server'
          description: 'Select version  minimum TLS version Azure Database for MySQL server to enforce'
        }
      }
      PostgreSQLEnableSSLDeployEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'PostgreSQL database servers. Deploy if not exist set minimum TLS version Azure Database for PostgreSQL server'
          description: 'Deploy a specific min TLS version requirement and enforce SSL on Azure Database for PostgreSQL server. Enforce the Server to client applications using minimum version of Tls to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
        }
      }
      PostgreSQLEnableSSLEffect: {
        metadata: {
          displayName: 'PostgreSQL database servers. Enforce SSL connection should be enabled for PostgreSQL database servers'
          description: 'Azure Database for PostgreSQL supports connecting your Azure Database for PostgreSQL server to client applications using Secure Sockets Layer (SSL). Enforcing SSL connections between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
        }
        type: 'String'
        defaultValue: 'Audit'
        allowedValues: [
          'Audit'
          'Disabled'
          'Deny'
        ]
      }
      PostgreSQLminimalTlsVersion: {
        type: 'String'
        defaultValue: 'TLS1_2'
        allowedValues: [
          'TLS1_2'
          'TLS1_0'
          'TLS1_1'
          'TLSEnforcementDisabled'
        ]
        metadata: {
          displayName: 'PostgreSQL database servers. Select version minimum TLS for MySQL server'
          description: 'PostgreSQL database servers. Select version  minimum TLS version Azure Database for MySQL server to enforce'
        }
      }
      RedisTLSDeployEffect: {
        type: 'String'
        defaultValue: 'Append'
        allowedValues: [
          'Append'
          'Disabled'
        ]
        metadata: {
          displayName: 'Azure Cache for Redis. Deploy a specific min TLS version requirement and enforce SSL Azure Cache for Redis'
          description: 'Deploy a specific min TLS version requirement and enforce SSL on Azure Cache for Redis. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
        }
      }
      RedisMinTlsVersion: {
        type: 'String'
        defaultValue: '1.2'
        allowedValues: [
          '1.2'
          '1.0'
          '1.1'
        ]
        metadata: {
          displayName: 'Azure Cache for Redis.Select version minimum TLS for Azure Cache for Redis'
          description: 'Select version  minimum TLS version for a Azure Cache for Redis to enforce'
        }
      }
      RedisTLSEffect: {
        metadata: {
          displayName: 'Azure Cache for Redis. Only secure connections to your Azure Cache for Redis should be enabled'
          description: 'Azure Cache for Redis. Audit enabling of only connections via SSL to Azure Cache for Redis. Use of secure connections ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking.'
        }
        type: 'String'
        defaultValue: 'Audit'
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
      }
      SQLManagedInstanceTLSDeployEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Azure Managed Instance. Deploy a specific min TLS version requirement and enforce SSL on SQL servers'
          description: 'Deploy a specific min TLS version requirement and enforce SSL on SQL servers. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
        }
      }
      SQLManagedInstanceMinTlsVersion: {
        type: 'String'
        defaultValue: '1.2'
        allowedValues: [
          '1.2'
          '1.0'
          '1.1'
        ]
        metadata: {
          displayName: 'Azure Managed Instance.Select version minimum TLS for Azure Managed Instance'
          description: 'Select version  minimum TLS version for Azure Managed Instanceto to  enforce'
        }
      }
      SQLManagedInstanceTLSEffect: {
        metadata: {
          displayName: 'SQL Managed Instance should have the minimal TLS version of 1.2'
          description: 'Setting minimal TLS version to 1.2 improves security by ensuring your SQL Managed Instance can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not recommended since they have well documented security vulnerabilities.'
        }
        type: 'String'
        defaultValue: 'Audit'
        allowedValues: [
          'Audit'
          'Disabled'
          'Deny'
        ]
      }
      SQLServerTLSDeployEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Azure SQL Database. Deploy a specific min TLS version requirement and enforce SSL on SQL servers'
          description: 'Deploy a specific min TLS version requirement and enforce SSL on SQL servers. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
        }
      }
      SQLServerminTlsVersion: {
        type: 'String'
        defaultValue: '1.2'
        allowedValues: [
          '1.2'
          '1.0'
          '1.1'
        ]
        metadata: {
          displayName: 'Azure SQL Database.Select version minimum TLS for Azure SQL Database'
          description: 'Select version  minimum TLS version for Azure SQL Database to enforce'
        }
      }
      SQLServerTLSEffect: {
        metadata: {
          displayName: 'Azure SQL Database should have the minimal TLS version of 1.2'
          description: 'Setting minimal TLS version to 1.2 improves security by ensuring your Azure SQL Database can only be accessed from clients using TLS 1.2. Using versions of TLS less than 1.2 is not recommended since they have well documented security vulnerabilities.'
        }
        type: 'String'
        defaultValue: 'Audit'
        allowedValues: [
          'Audit'
          'Disabled'
          'Deny'
        ]
      }
      StorageDeployHttpsEnabledEffect: {
        metadata: {
          displayName: 'Azure Storage Account. Deploy Secure transfer to storage accounts should be enabled'
          description: 'Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking'
        }
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
      }
      StorageminimumTlsVersion: {
        type: 'String'
        defaultValue: 'TLS1_2'
        allowedValues: [
          'TLS1_2'
          'TLS1_1'
          'TLS1_0'
        ]
        metadata: {
          displayName: 'Storage Account select minimum TLS version'
          description: 'Select version  minimum TLS version on Azure Storage Account to enforce'
        }
      }
      StorageHttpsEnabledEffect: {
        metadata: {
          displayName: 'Azure Storage Account. Secure transfer to storage accounts should be enabled'
          description: 'Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking'
        }
        type: 'String'
        defaultValue: 'Audit'
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
      }
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'AKSIngressHttpsOnlyEffect'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d')
        parameters: {
          effect: {
            value: '[parameters(\'AKSIngressHttpsOnlyEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'MySQLEnableSSLDeployEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-MySQL-sslEnforcement')
        parameters: {
          effect: {
            value: '[parameters(\'MySQLEnableSSLDeployEffect\')]'
          }
          minimalTlsVersion: {
            value: '[parameters(\'MySQLminimalTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'MySQLEnableSSLEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deny-MySql-http')
        parameters: {
          effect: {
            value: '[parameters(\'MySQLEnableSSLEffect\')]'
          }
          minimalTlsVersion: {
            value: '[parameters(\'MySQLminimalTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'PostgreSQLEnableSSLDeployEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-PostgreSQL-sslEnforcement')
        parameters: {
          effect: {
            value: '[parameters(\'PostgreSQLEnableSSLDeployEffect\')]'
          }
          minimalTlsVersion: {
            value: '[parameters(\'PostgreSQLminimalTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'PostgreSQLEnableSSLEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deny-PostgreSql-http')
        parameters: {
          effect: {
            value: '[parameters(\'PostgreSQLEnableSSLEffect\')]'
          }
          minimalTlsVersion: {
            value: '[parameters(\'PostgreSQLminimalTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'RedisTLSDeployEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Append-Redis-sslEnforcement')
        parameters: {
          effect: {
            value: '[parameters(\'RedisTLSDeployEffect\')]'
          }
          minimumTlsVersion: {
            value: '[parameters(\'RedisMinTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'RedisdisableNonSslPort'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Append-Redis-disableNonSslPort')
        parameters: {
          effect: {
            value: '[parameters(\'RedisTLSDeployEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'RedisDenyhttps'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deny-Redis-http')
        parameters: {
          effect: {
            value: '[parameters(\'RedisTLSEffect\')]'
          }
          minimumTlsVersion: {
            value: '[parameters(\'RedisMinTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'SQLManagedInstanceTLSDeployEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-SqlMi-minTLS')
        parameters: {
          effect: {
            value: '[parameters(\'SQLManagedInstanceTLSDeployEffect\')]'
          }
          minimalTlsVersion: {
            value: '[parameters(\'SQLManagedInstanceMinTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'SQLManagedInstanceTLSEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deny-SqlMi-minTLS')
        parameters: {
          effect: {
            value: '[parameters(\'SQLManagedInstanceTLSEffect\')]'
          }
          minimalTlsVersion: {
            value: '[parameters(\'SQLManagedInstanceMinTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'SQLServerTLSDeployEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-SQL-minTLS')
        parameters: {
          effect: {
            value: '[parameters(\'SQLServerTLSDeployEffect\')]'
          }
          minimalTlsVersion: {
            value: '[parameters(\'SQLServerminTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'SQLServerTLSEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deny-Sql-minTLS')
        parameters: {
          effect: {
            value: '[parameters(\'SQLServerTLSEffect\')]'
          }
          minimalTlsVersion: {
            value: '[parameters(\'SQLServerminTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'StorageHttpsEnabledEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deny-Storage-minTLS')
        parameters: {
          effect: {
            value: '[parameters(\'StorageHttpsEnabledEffect\')]'
          }
          minimumTlsVersion: {
            value: '[parameters(\'StorageMinimumTlsVersion\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'StorageDeployHttpsEnabledEffect'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-Storage-sslEnforcement')
        parameters: {
          effect: {
            value: '[parameters(\'StorageDeployHttpsEnabledEffect\')]'
          }
          minimumTlsVersion: {
            value: '[parameters(\'StorageMinimumTlsVersion\')]'
          }
        }
        groupNames: []
      }
    ]
    policyDefinitionGroups: null
  }
}
