targetScope = 'managementGroup'

param location string = deployment().location
param managementGroupId string
param userAssignedIdentity string
param resourceGroupName string
param workspaceName string
param automationAccountName string
param dataRetention int

module Deploy_Log_Analytics '../../../../shared/policy-assignment.bicep' = {
  name: 'Deploy-Log-Analytics-Assignment'
  scope: managementGroup(managementGroupId)
  params: {
    location: location
    policyAssignmentName: 'Deploy-Log-Analytics'
    policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '8e3e61b3-0b32-22d5-4edf-55f87fdb5955')
    userAssignedIdentity: userAssignedIdentity
    parameters: {
      effect: {
        value: 'DeployIfNotExists'
      }
      workspaceName: {
        value: workspaceName
      }
      automationAccountName: {
        value: automationAccountName
      }
      workspaceRegion: {
        value: location
      }
      automationRegion: {
        value: location
      }
      dataRetention: {
        value: string(dataRetention)
      }
      sku: {
        value: 'pergb2018'
      }
      rgName: {
        value: resourceGroupName
      }
    }
  }
}
