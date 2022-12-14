targetScope = 'subscription'

@allowed([
  'Environment'
  'EnvironmentType'
  'DataOwner'
])
param tagnames string

@allowed([
  'Sandbox'
  'NonProduction'
  'Production'
  'Confidential'
])
param environment string

@allowed([
  'Sandbox'
  'Development'
  'Test'
  'QuailtyAssurance'
  'PreProduction'
  'Production'
  'Confidential'
])
param environmentType string




resource reqTagsOnSub_policyAssignments1 'Microsoft.Authorization/policyAssignments@2020-09-01' = [for name in tagNames: {
  name: 'reqTag-${name}-OnSub'
  properties: {
    policyDefinitionId: reqTagSub_PolicyDef.id
    displayName: 'Require tag "${name}" on Subscription'
    parameters: {
      tagName: {
        value: '${name}'
      }
    }
  }
}]

resource reqTagSub_PolicyDef 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'required-tag-on-subscription'
  properties: {
    displayName: 'Require tag on subscription'
    policyType: 'Custom'
    mode: 'All'
    description: 'Requires the specified tag on subscription level.'
    parameters: {
      tagName: {
        type: 'String'
        metadata: {
          displayName: 'Tag Name'
          description: 'Name of the tag, such as "Environment"'
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
            equals: 'Microsoft.Subscriptions'
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
