targetScope = 'managementGroup'
resource Deny_AA_child_resources 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-AA-child-resources'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'No child resources in Automation Account'
    description: 'This policy denies the creation of child resources on the Automation Account'
    metadata: {
      version: '1.0.0'
      category: 'Automation'
    }
    parameters: {
      effect: {
        type: 'String'
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
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
            in: [
              'Microsoft.Automation/automationAccounts/runbooks'
              'Microsoft.Automation/automationAccounts/variables'
              'Microsoft.Automation/automationAccounts/modules'
              'Microsoft.Automation/automationAccounts/credentials'
              'Microsoft.Automation/automationAccounts/connections'
              'Microsoft.Automation/automationAccounts/certificates'
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}