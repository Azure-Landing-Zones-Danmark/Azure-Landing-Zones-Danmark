targetScope = 'managementGroup'
resource Deny_MachineLearning_Compute_SubnetId 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-MachineLearning-Compute-SubnetId'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: 'Enforce subnet connectivity for Azure Machine Learning compute clusters and compute instances'
    description: 'Enforce subnet connectivity for Azure Machine Learning compute clusters and compute instances.'
    metadata: {
      version: '1.0.0'
      category: 'Machine Learning'
    }
    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'Audit'
          'Disabled'
          'Deny'
        ]
        defaultValue: 'Deny'
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.MachineLearningServices/workspaces/computes'
          }
          {
            field: 'Microsoft.MachineLearningServices/workspaces/computes/computeType'
            in: [
              'AmlCompute'
              'ComputeInstance'
            ]
          }
          {
            anyOf: [
              {
                field: 'Microsoft.MachineLearningServices/workspaces/computes/subnet.id'
                exists: false
              }
              {
                value: '[empty(field(\'Microsoft.MachineLearningServices/workspaces/computes/subnet.id\'))]'
                equals: true
              }
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