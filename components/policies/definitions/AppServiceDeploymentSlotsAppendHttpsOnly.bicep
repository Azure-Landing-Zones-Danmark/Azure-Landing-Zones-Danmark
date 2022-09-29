targetScope = 'managementGroup'

resource AppServiceDeploymentSlotsAppendHttpsOnly 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'AppServiceDeploymentSlotsAppendHttpsOnly'
  properties: {
    displayName: 'Append HTTPS only on App Service Deployment Slots'
    description: 'Append HTTPS only on App Service Deployment Slots'
    mode: 'Indexed'
    metadata: {
      category: 'App Service'
    }
    parameters: {}
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Web/sites/slots'
          }
          {
            field: 'Microsoft.Web/sites/slots/httpsOnly'
            notEquals: 'true'
          }
        ]
      }
      then: {
        effect: 'append'
        details: [
          {
            field: 'Microsoft.Web/sites/slots/httpsOnly'
            value: 'true'
          }
        ]
      }
    }
  }
}
