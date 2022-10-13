targetScope = 'managementGroup'
resource Deploy_ASC_SecurityContacts 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deploy-ASC-SecurityContacts'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deploy Security Contacts'
    description: 'Deploy Security Contacts'
    metadata: {
      version: '1.0.0'
      category: 'Security Center'
    }
    parameters: {
      emailSecurityContact: {
        type: 'string'
        metadata: {
          displayName: 'Security contacts email address'
          description: 'Provide email address for Azure Security Center contact details'
        }
      }
      effect: {
        type: 'string'
        defaultValue: 'DeployIfNotExists'
        allowedValues: [
          'DeployIfNotExists'
          'Disabled'
        ]
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Resources/subscriptions'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          type: 'Microsoft.Security/securityContacts'
          deploymentScope: 'subscription'
          existenceScope: 'subscription'
          roleDefinitionIds: [
            '/providers/Microsoft.Authorization/roleDefinitions/fb1c8493-542b-48eb-b624-b4c8fea62acd'
          ]
          existenceCondition: {
            allOf: [
              {
                field: 'Microsoft.Security/securityContacts/email'
                contains: '[parameters(\'emailSecurityContact\')]'
              }
              {
                field: 'type'
                equals: 'Microsoft.Security/securityContacts'
              }
              {
                field: 'Microsoft.Security/securityContacts/alertNotifications'
                equals: 'On'
              }
              {
                field: 'Microsoft.Security/securityContacts/alertsToAdmins'
                equals: 'On'
              }
            ]
          }
          deployment: {
            properties: {
              mode: 'incremental'
              parameters: {
                emailSecurityContact: {
                  value: '[parameters(\'emailSecurityContact\')]'
                }
              }
              template: {
                '$schema': 'https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  emailSecurityContact: {
                    type: 'string'
                    metadata: {
                      description: 'Security contacts email address'
                    }
                  }
                }
                variables: {
                }
                resources: [
                  {
                    type: 'Microsoft.Security/securityContacts'
                    name: 'default'
                    apiVersion: '2020-01-01-preview'
                    properties: {
                      emails: '[parameters(\'emailSecurityContact\')]'
                      notificationsByRole: {
                        state: 'On'
                        roles: [
                          'Owner'
                        ]
                      }
                      alertNotifications: {
                        state: 'On'
                        minimalSeverity: 'High'
                      }
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
