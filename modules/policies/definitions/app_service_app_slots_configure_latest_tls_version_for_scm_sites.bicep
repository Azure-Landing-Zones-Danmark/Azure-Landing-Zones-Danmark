targetScope = 'managementGroup'

resource App_Service_App_Slots_Configure_Latest_TLS_Version_For_SCM_Sites 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'App-Service-App-Slots-Configure-Latest-TLS-Version-For-SCM-Sites'
  properties: {
    displayName: 'Configure App Service app slots to use the latest TLS version for SCM sites'
    description: 'Upgrade to the latest TLS version.'
    policyType: 'Custom'
    mode: 'Indexed'
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
            equals: 'Microsoft.Web/sites/slots'
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
          type: 'Microsoft.Web/sites/slots/config'
          name: 'web'
          existenceCondition: {
            field: 'Microsoft.Web/sites/slots/config/scmMinTlsVersion'
            equals: 'true'
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
                siteId: {
                  value: '[field(\'id\')]'
                }
              }
              template: {
                '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  siteName: {
                    type: 'string'
                  }
                  siteId: {
                    type: 'string'
                  }
                }
                variables: {
                }
                resources: [
                  {
                    type: 'Microsoft.Web/sites/slots/config'
                    apiVersion: '2021-02-01'
                    name: '[format(\'{0}/{1}/web\', split(split(parameters(\'siteId\'),\'/\')[7]), parameters(\'siteName\'))]'
                    properties: {
                      scmMinTlsVersion: '1.2'
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