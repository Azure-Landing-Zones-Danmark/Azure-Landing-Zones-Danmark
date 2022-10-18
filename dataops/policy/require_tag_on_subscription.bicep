targetScope = 'subscription'

@allowed([
  'Sandbox'
  'Non-Production'
  'Production'
  'Confidential'
])
param environment string

@allowed([
  'Sandbox'
  'Development'
  'Test'
  'QuailtyAssurance'
  'Pre-Production'
  'Production'
  'Confidential'
])
param environmentType string




resource reqTagsOnSubscription1 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'environment'
  properties: {
    policyDefinitionId: reqTagSub_PolicyDef.id
    displayName: 'Require tag "environment" on Subscription'
    parameters: {
      tagName: {
        value: '${name}'
      }
    }
  }
}

resource reqTagRG_PolicyDef 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'require-tag-on-rg'
  properties: {
    displayName: 'Require tag on resource groups'
    policyType: 'Custom'
    mode: 'All'
    description: 'Requires the specified tag when any resource group is created or updated.'
    parameters: {
      tagName: {
        type: 'String'
        metadata: {
          displayName: 'Tag Name'
          description: 'Name of the tag, such as "environment"'
        }
      }
    }
    metadata: {
      category: 'Tags'
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Resources/subscriptions/resourceGroups'
          }
          {
            field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]'
            exists: false
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}
