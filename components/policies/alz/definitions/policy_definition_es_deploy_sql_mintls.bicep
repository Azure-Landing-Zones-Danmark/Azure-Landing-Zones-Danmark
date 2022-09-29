targetScope = 'managementGroup'
resource Deploy_SQL_minTLS 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deploy-SQL-minTLS'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'SQL servers deploys a specific min TLS version requirement.'
    description: 'Deploys a specific min TLS version requirement and enforce SSL on SQL servers. Enables secure server to client by enforce  minimal Tls Version to secure the connection between your database server and your client applications helps protect against \'man in the middle\' attacks by encrypting the data stream between the server and your application. This configuration enforces that SSL is always enabled for accessing your database server.'
    metadata: {
      version: '1.0.0'
      category: 'SQL'
    }
    parameters: {
      effect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Effect SQL servers'
          description: 'Enable or disable the execution of the policy minimum TLS version SQL servers'
        }
      }
      minimalTlsVersion: {
        type: 'String'
        defaultValue: '1.2'
        allowedValues: [
          '1.2'
          '1.1'
          '1.0'
        ]
        metadata: {
          displayName: 'Select version for SQL server'
          description: 'Select version minimum TLS version SQL servers to enforce'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Sql/servers'
          }
          {
            field: 'Microsoft.Sql/servers/minimalTlsVersion'
            notequals: '[parameters(\'minimalTlsVersion\')]'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          type: 'Microsoft.Sql/servers'
          existenceCondition: {
            allOf: [
              {
                field: 'Microsoft.Sql/servers/minimalTlsVersion'
                equals: '[parameters(\'minimalTlsVersion\')]'
              }
            ]
          }
          name: 'current'
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
          ]
          deployment: {
            properties: {
              mode: 'Incremental'
              template: {
                '$schema': 'http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  resourceName: {
                    type: 'String'
                  }
                  minimalTlsVersion: {
                    type: 'String'
                  }
                  location: {
                    type: 'String'
                  }
                }
                variables: {
                }
                resources: [
                  {
                    type: 'Microsoft.Sql/servers'
                    apiVersion: '2019-06-01-preview'
                    name: '[concat(parameters(\'resourceName\'))]'
                    location: '[parameters(\'location\')]'
                    properties: {
                      minimalTlsVersion: '[parameters(\'minimalTlsVersion\')]'
                    }
                  }
                ]
                outputs: {
                }
              }
              parameters: {
                resourceName: {
                  value: '[field(\'name\')]'
                }
                minimalTlsVersion: {
                  value: '[parameters(\'minimalTlsVersion\')]'
                }
                location: {
                  value: '[field(\'location\')]'
                }
              }
            }
          }
        }
      }
    }
  }
}