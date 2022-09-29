targetScope = 'managementGroup'

resource AppServiceAppendHttpsOnly 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'AppServiceAppendHttpsOnly'
  properties: {
    displayName: 'Append HTTPS only on App Services'
    description: 'Append HTTPS only on App Services'
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
            equals: 'Microsoft.Web/sites'
          }
          {
            field: 'Microsoft.Web/sites/httpsOnly'
            notEquals: 'true'
          }
        ]
      }
      then: {
        effect: 'append'
        details: [
          {
            field: 'Microsoft.Web/sites/httpsOnly'
            value: 'true'
          }
        ]
      }
    }
  }
}
