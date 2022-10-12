targetScope = 'managementGroup'

resource App_Service_Apps_Configure_Disable_FTPS 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'App-Service-Apps-Configure-Disable-FTPS'
  properties: {
    displayName: 'Configure App Service apps to disable FTP and FTPS'
    policyType: 'BuiltIn'
    mode: 'Indexed'
    description: 'Disable FTP and FTPS'
    metadata: {
      version: '1.0'
      category: 'App Service'
    }
    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        defaultValue: 'DeployIfNotExists'
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Web/sites'
          }
          {
            field: 'kind'
            notContains: 'functionapp'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          type: 'Microsoft.Web/sites/config'
          name: 'web'
          existenceCondition: {
            field: 'Microsoft.Web/sites/config/ftpsState'
            equals: 'Disabled'
          }
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/de139f84-1756-47ae-9be6-808fbbe84772'
          ]
          deployment: {
            properties: {
              mode: 'incremental'
              parameters: {
                siteName: {
                  value: '[field(\'name\')]'
                }
              }
              template: {
                '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  siteName: {
                    type: 'string'
                  }
                }
                variables: {
                }
                resources: [
                  {
                    type: 'Microsoft.Web/sites/config'
                    apiVersion: '2021-02-01'
                    name: '[concat(parameters(\'siteName\'), \'/web\')]'
                    properties: {
                      ftpsState: 'Disabled'
                    }
                  }
                ]
                outputs: {
                }
              }
            }
          }
        }
      }
    }
  }
}
