targetScope = 'managementGroup'
resource Deny_VNET_Peer_Cross_Sub 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'Deny-VNET-Peer-Cross-Sub'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Deny vNet peering cross subscription.'
    description: 'This policy denies the creation of vNet Peerings outside of the same subscriptions under the assigned scope.'
    metadata: {
      version: '1.0.1'
      category: 'Network'
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
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
          }
          {
            field: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings/remoteVirtualNetwork.id'
            notcontains: '[subscription().id]'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}