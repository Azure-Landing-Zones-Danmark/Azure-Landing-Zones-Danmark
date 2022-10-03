targetScope = 'managementGroup'
resource Deploy_Sql_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Deploy-Sql-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Deploy SQL Database built-in SQL security configuration'
    description: 'Deploy auditing, Alert, TDE and SQL vulnerability to SQL Databases when it not exist in the deployment'
    metadata: {
      version: '1.0.0'
      category: 'SQL'
    }
    parameters: {
      vulnerabilityAssessmentsEmail: {
        metadata: {
          description: 'The email address to send alerts'
          displayName: 'The email address to send alerts'
        }
        type: 'String'
      }
      vulnerabilityAssessmentsStorageID: {
        metadata: {
          description: 'The storage account ID to store assessments'
          displayName: 'The storage account ID to store assessments'
        }
        type: 'String'
      }
      SqlDbTdeDeploySqlSecurityEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Deploy SQL Database Transparent Data Encryption '
          description: 'Deploy the Transparent Data Encryption when it is not enabled in the deployment'
        }
      }
      SqlDbSecurityAlertPoliciesDeploySqlSecurityEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Deploy SQL Database security Alert Policies configuration with email admin accounts'
          description: 'Deploy the security Alert Policies configuration with email admin accounts when it not exist in current configuration'
        }
      }
      SqlDbAuditingSettingsDeploySqlSecurityEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Deploy SQL database auditing settings'
          description: 'Deploy auditing settings to SQL Database when it not exist in the deployment'
        }
      }
      SqlDbVulnerabilityAssessmentsDeploySqlSecurityEffect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Deploy SQL Database vulnerability Assessments'
          description: 'Deploy SQL Database vulnerability Assessments when it not exist in the deployment. To the specific  storage account in the parameters'
        }
      }
    }
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'SqlDbTdeDeploySqlSecurity'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-Sql-Tde')
        parameters: {
          effect: {
            value: '[parameters(\'SqlDbTdeDeploySqlSecurityEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'SqlDbSecurityAlertPoliciesDeploySqlSecurity'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-Sql-SecurityAlertPolicies')
        parameters: {
          effect: {
            value: '[parameters(\'SqlDbSecurityAlertPoliciesDeploySqlSecurityEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'SqlDbAuditingSettingsDeploySqlSecurity'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-Sql-AuditingSettings')
        parameters: {
          effect: {
            value: '[parameters(\'SqlDbAuditingSettingsDeploySqlSecurityEffect\')]'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'SqlDbVulnerabilityAssessmentsDeploySqlSecurity'
        policyDefinitionId: extensionResourceId(managementGroup().id, 'Microsoft.Authorization/policyDefinitions', 'Deploy-Sql-vulnerabilityAssessments')
        parameters: {
          effect: {
            value: '[parameters(\'SqlDbVulnerabilityAssessmentsDeploySqlSecurityEffect\')]'
          }
          vulnerabilityAssessmentsEmail: {
            value: '[parameters(\'vulnerabilityAssessmentsEmail\')]'
          }
          vulnerabilityAssessmentsStorageID: {
            value: '[parameters(\'vulnerabilityAssessmentsStorageID\')]'
          }
        }
        groupNames: []
      }
    ]
    policyDefinitionGroups: null
  }
}
