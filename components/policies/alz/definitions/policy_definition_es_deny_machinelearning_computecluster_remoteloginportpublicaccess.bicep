targetScope = 'managementGroup'
resource Deny_MachineLearning_ComputeCluster_RemoteLoginPortPublicAccess 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-MachineLearning-ComputeCluster-RemoteLoginPortPublicAccess'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny public access of Azure Machine Learning clusters via SSH'
    description: 'Deny public access of Azure Machine Learning clusters via SSH.'
    metadata: {
      version: '1.1.0'
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
            equals: 'AmlCompute'
          }
          {
            anyOf: [
              {
                field: 'Microsoft.MachineLearningServices/workspaces/computes/remoteLoginPortPublicAccess'
                exists: false
              }
              {
                field: 'Microsoft.MachineLearningServices/workspaces/computes/remoteLoginPortPublicAccess'
                notEquals: 'Disabled'
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