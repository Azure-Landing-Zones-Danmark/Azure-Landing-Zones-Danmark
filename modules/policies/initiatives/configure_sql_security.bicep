targetScope = 'managementGroup'

resource Configure_SQL_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-SQL-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure SQL security'
    description: 'This policy initiative is a group of policies that configures SQL security.'
    metadata: {
      version: '1.0'
      category: 'SQL'
    }
    parameters: {
      logAnalytics: {
        type: 'String'
        metadata: {
          displayName: 'Primary Log Analytics workspace'
          description: 'Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant \'Log Analytics Contributor\' permissions (or similar) to the policy assignment\'s principal ID.'
          strongType: 'omsWorkspace'
        }
      }
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigureAzureSqlServerToDisablePublicNetworkAccess'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '28b0b1e5-17ba-4963-a7a4-5a1ab4400a0b')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureSynapseWorkspaceDedicatedSqlMinimumTlsVersion'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '8b5c654c-fb07-471b-aa8f-15fea733f140')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAdvancedThreatProtectionToBeEnabledOnAzureDatabaseForMysqlServers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '80ed5239-4122-41ed-b54a-6f1fa7552816')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAdvancedThreatProtectionToBeEnabledOnAzureDatabaseForMariadbServers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'a6cf7411-da9e-49e2-aec0-cba0250eaf8c')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAdvancedThreatProtectionToBeEnabledOnAzureDatabaseForPostgresqlServers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'db048e65-913c-49f9-bb5f-1084184671d3')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureArcEnabledMachinesRunningSqlServerToHaveSqlServerExtensionInstalled'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'fd2d1a6e-6d95-4df2-ad00-504bf0273406')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployAdvancedDataSecurityOnSqlServers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '6134c3db-786f-471e-87bc-8f479dc890f6')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureSqlServersToHaveAuditingEnabledToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '25da7dfb-0666-4a15-a8f5-402127efd8bb')
        parameters: {
          logAnalyticsWorkspaceId: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureSynapseWorkspacesToHaveAuditingEnabledToLogAnalyticsWorkspace'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '32ba8d30-07c0-4136-ab18-9a11bf4a67b7')
        parameters: {
          logAnalyticsWorkspaceId: {
            value: '[parameters(\'logAnalytics\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForPostgresqlToDisablePublicNetworkAccess'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'PostgreSQL-Configure-Disable-Public-Network-Access')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForMysqlToEnforceSsl'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'MySQL-Configure-Enforce-SSL')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForPostgresqlToEnforceSsl'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'PostgreSQL-Configure-Enforce-SSL')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForPostgresqlToUseTheLatestTlsVersion'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'PostgreSQL-Configure-Minimum-TLS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForMariadbToEnforceSsl'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'MariaDB-Configure-Enforce-SSL')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForMariadbToUseTheLatestTlsVersion'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'MariaDB-Configure-Minimum-TLS')
        parameters: {}
        groupNames: []
      }

      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForMysqlToEnforceSsl'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'MySQL-Configure-Enforce-SSL')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForMysqlToUseTheLatestTlsVersion'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'MySQL-Configure-Minimum-TLS')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForPostgresqlToDisablePublicNetworkAccess'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'PostgreSQL-Configure-Disable-Public-Network-Access')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForPostgresqlFlexibleServerToDisablePublicNetworkAccess'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'PostgreSQL-Flex-Configure-Disable-Public-Network-Access')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForMariadbToDisablePublicNetworkAccess'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'MariaDB-Configure-Disable-Public-Network-Access')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForMysqlToDisablePublicNetworkAccess'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'MySQL-Configure-Disable-Public-Network-Access')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureAzureDatabaseForMysqlFlexibleServerToDisablePublicNetworkAccess'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'MySQL-Flex-Configure-Disable-Public-Network-Access')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeploySqlDbTransparentDataEncryption'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '86a912f6-9a06-4e26-b447-11b16ba8659f')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
