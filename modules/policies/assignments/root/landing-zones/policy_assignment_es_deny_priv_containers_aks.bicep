targetScope = 'managementGroup'
resource Deny_Priv_Containers_AKS 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'Deny-Priv-Containers-AKS'
  properties: {
    description: 'Do not allow privileged containers creation in a Kubernetes cluster. This recommendation is part of CIS 5.2.1 which is intended to improve the security of your Kubernetes environments. This policy is generally available for Kubernetes Service (AKS), and preview for AKS Engine and Azure Arc enabled Kubernetes. For more information, see https://aka.ms/kubepolicydoc.'
    displayName: 'Kubernetes cluster should not allow privileged containers'
    notScopes: []
    parameters: {
      effect: {
        value: 'deny'
      }
    }
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '95edb821-ddaf-4404-9732-666045e056b4')
    enforcementMode: 'Default'
  }
  identity: {
    type: 'None'
  }
}