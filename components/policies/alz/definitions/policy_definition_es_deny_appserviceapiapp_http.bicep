targetScope = 'managementGroup'
resource Deny_AppServiceApiApp_http 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-AppServiceApiApp-http'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'API App should only be accessible over HTTPS'
    description: 'Use of HTTPS ensures server/service authentication and protects data in transit from network layer eavesdropping attacks.'
    metadata: {
      version: '1.0.0'
      category: 'App Service'
    }
    parameters: {
      effect: {
        type: 'String'
        defaultValue: 'Deny'
        allowedValues: [
          'Audit'
          'Disabled'
          'Deny'
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
            equals: 'Microsoft.Web/sites'
          }
          {
            field: 'kind'
            like: '*api'
          }
          {
            field: 'Microsoft.Web/sites/httpsOnly'
            equals: 'false'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}