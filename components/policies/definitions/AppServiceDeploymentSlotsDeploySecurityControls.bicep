targetScope = 'managementGroup'

resource AppServiceDeploymentSlotsDeploySecurityControls 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'AppServiceDeploymentSlotsDeploySecurityControls'
  properties: {
    displayName: 'Deploy Security Controls for App Service Deployment Slots'
    description: 'Deploy Security Controls for App Service Deployment Slots'
    mode: 'Indexed'
    metadata: {
      category: 'App Service'
    }
    parameters: {
      effect: {
        type: 'String'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
      }
    }
    policyRule: {
      if: {
        field: 'type'
        equals: 'Microsoft.Web/sites/slots'
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          roleDefinitionIds: [
            '/providers/Microsoft.Authorization/roleDefinitions/de139f84-1756-47ae-9be6-808fbbe84772'
          ]
          type: 'Microsoft.Web/sites/slots/config'
          name: 'web'
          existenceCondition: {
            allOf: [
              {
                field: 'Microsoft.Web/sites/slots/config/minTlsVersion'
                equals: '1.2'
              }
              {
                field: 'Microsoft.Web/sites/slots/config/http20Enabled'
                equals: 'true'
              }
              {
                field: 'Microsoft.Web/sites/slots/config/ftpsState'
                equals: 'Disabled'
              }
              {
                field: 'Microsoft.Web/sites/slots/config/scmMinTlsVersion'
                equals: '1.2'
              }
            ]
          }
          deployment: {
            properties: {
              mode: 'Incremental'
              parameters: {
                resourceName: {
                  value: '[field(\'fullName\')]'
                }
                location: {
                  value: '[field(\'location\')]'
                }
              }
              template: {
                '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  resourceName: {
                    type: 'String'
                  }
                  location: {
                    type: 'String'
                  }
                }
                variables: {}
                resources: [
                  {
                    type: 'Microsoft.Web/sites/slots/config'
                    apiVersion: '2020-12-01'
                    name: '[concat(parameters(\'resourceName\'), \'/web\')]'
                    location: '[parameters(\'location\')]'
                    properties: {
                      http20Enabled: true
                      minTlsVersion: '1.2'
                      scmMinTlsVersion: '1.2'
                      ftpsState: 'Disabled'
                    }
                  }
                ]
                outputs: {}
              }
            }
          }
        }
      }
    }
  }
}
