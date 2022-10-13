targetScope = 'managementGroup'

resource Configure_VM_Security 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'Configure-VM-Security'
  properties: {
    policyType: 'Custom'
    displayName: 'Configure VM security'
    description: 'This policy initiative is a group of policies that configures VM security.'
    metadata: {
      version: '1.0'
      category: 'Guest Configuration'
    }
    parameters: {}
    policyDefinitions: [
      {
        policyDefinitionReferenceId: 'ConfigurePeriodicCheckingForMissingSystemUpdatesOnAzureVirtualMachines'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '59efceea-0c96-497e-a4a1-4eb2290dac15')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigurePeriodicCheckingForMissingSystemUpdatesOnAzureArcEnabledServers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'bfea026e-043f-4ff4-9d1b-bf301ca7ff46')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureSecureCommunicationProtocolsTls11OrTls12OnWindowsServers'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '828ba269-bf7f-4082-83dd-633417bc391d')
        parameters: {
          IncludeArcMachines: {
            value: true
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureMachinesToReceiveAVulnerabilityAssessmentProvider'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '13ce0167-8ca6-4048-8e6b-f996402e3c1b')
        parameters: {
          vaType: {
            value: 'mdeTvm'
          }
        }
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureSupportedLinuxVirtualMachinesToAutomaticallyEnableSecureBoot'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '95406fc3-1f69-47b0-8105-4c03b276ec5c')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureSupportedWindowsVirtualMachinesToAutomaticallyEnableSecureBoot'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '7cb1b219-61c6-47e0-b80c-4472cadeeb5f')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureSupportedVirtualMachinesToAutomaticallyEnableVtpm'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'e494853f-93c3-4e44-9210-d12f61a64b34')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureDependencyAgentOnAzureArcEnabledLinuxServersWithAzureMonitoringAgentSettings'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '08a4470f-b26d-428d-97f4-7e3e9c92b366')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'ConfigureDependencyAgentOnAzureArcEnabledWindowsServersWithAzureMonitoringAgentSettings'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '84cfed75-dfd4-421b-93df-725b479d356a')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployDependencyAgentForLinuxVirtualMachineScaleSetsWithAzureMonitoringAgentSettings'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '2fea0c12-e7d4-4e03-b7bf-c34b2b8d787d')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployDependencyAgentForLinuxVirtualMachinesWithAzureMonitoringAgentSettings'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'd55b81e1-984f-4a96-acab-fae204e3ca7f')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployDependencyAgentToBeEnabledOnWindowsVirtualMachineScaleSetsWithAzureMonitoringAgentSettings'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', 'af0082fd-fa58-4349-b916-b0e47abb0935')
        parameters: {}
        groupNames: []
      }
      {
        policyDefinitionReferenceId: 'DeployDependencyAgentToBeEnabledOnWindowsVirtualMachinesWithAzureMonitoringAgentSettings'
        policyDefinitionId: tenantResourceId('Microsoft.Authorization/policyDefinitions', '89ca9cc7-25cd-4d53-97ba-445ca7a1f222')
        parameters: {}
        groupNames: []
      }
    ]
    policyDefinitionGroups: []
  }
}
