# Policies Module

This folder contains policy definitions, initiatives, and assignments imported from the [Azure Landing Zones (ALZ) - Bicep](https://github.com/Azure/ALZ-Bicep).

TODO: Automate policy import using a GitHub Action.

## Notes

All definitions and initiatives are deployed to the root management group.

All definitions, initiatives, and assignments are built using atomic management group level templates written in *bicep*.

## Definitions

Definitions are stored in original JSON format and not converted to Bicep.

They can be individually deployed and tested using `New-AzPolicyDefinition`.

## Initiatives

Definitions are stored in original JSON format and not converted to Bicep.

They can be individually deployed and tested using `New-AzPolicySetDefinition`.

## Assignments

Policy assignments are built as atomic Bicep templates.

They can be individually deployed and tested using:

```bash
az deployment mg create --management-group-id lz-canary --location westeurope --template-file my-policy-assignment.bicep
```

or

```powershell
New-AzManagementGroupDeployment -ManagementGroupId lz-canary -Location westeurope -TemplateFile my-policy-assignment.bicep
```

Policies which can be remediated must be assigned using a managed identity with the appropriate permissions.

This has been simplified using a user assigned managed identity which has *owner* rights on the entire management group hierarchy.

## Phased Rollout Strategy - Continuous Deployment

A policy change in a PR will be deployed and validated in the *CANARY* management group structure.

If approved it will be deployed to the *PRODUCTION* management group structure.

## How To

Prefer policies in this order:

- [Built-in policies](https://github.com/Azure/azure-policy)
- [Community policies](https://github.com/Azure/Community-Policy)
- [Azure Landing Zones (ALZ) - Bicep](https://github.com/Azure/ALZ-Bicep/tree/main/infra-as-code/bicep/modules/policy/definitions/lib>)
- Create your own with inspiration from above

### Get Aliases

```bash
namespace=Microsoft.Storage
az provider show --namespace $namespace --expand "resourceTypes/aliases" --query "resourceTypes[].aliases[].name"
```

#### Modifiable Properties

```powershell
Get-AzPolicyAlias |
Select-Object -ExpandProperty "Aliases" |
Where-Object { $PSItem.DefaultMetadata.Attributes -eq "Modifiable" } |
Select-Object -ExpandProperty Name |
Set-Clipboard
```

## Out of scope

Automatic deletion of definitions, initiatives, and assignments which exist in Azure but not in the code.

## Remove Policies, Initatives and Assignments

To remove a policy:

```powershell
Remove-AzPolicyDefinition -Name 'PolicyName' -ManagementGroupName 'managementGroupName' -Force
```

To remove an initiative:

```powershell
Remove-AzPolicySetDefinition -Name 'InitiativeName' -ManagementGroupName 'managementGroupName' -Force
```

To remove an assignment:

```powershell
Remove-AzPolicyAssignment -Name 'assignmentName' -Scope 'managementGroupResourceID'
```

To remove all custom policies, initiatives and assignments, see ['Remove-Policy.ps1'](../../scripts/Remove-Policy.ps1)

To rest Defender for Cloud to default settings, see ['Reset-DefenderForCloud.ps1'](../../scripts/Reset-DefenderForCloud.ps1)
