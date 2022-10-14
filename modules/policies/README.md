# Policies Module

This folder contains policy definitions, initiatives, and assignments imported from the [Azure Landing Zones (ALZ) - Bicep](https://github.com/Azure/ALZ-Bicep).

TODO: Automate policy import using a GitHub Action.

## Notes

All definitions and initiatives are deployed to the root management group.

All definitions, initiatives, and assignments are built using atomic management group level templates written i *bicep*.

## Definitions/Initiatives/Assignments

All definitions, initiatives, and policy assignments are built as atomic Bicep templates.

They can be individually deployed and tested like so:

```bash
az deployment mg create --management-group-id lz-canary --location westeurope --template-file my-policy.bicep
```

```powershell
New-AzManagementGroupDeployment -ManagementGroupId lz-canary -Location westeurope -TemplateFile my-policy.bicep
```

## Phased Rollout Strategy - Continuous Deployment

A policy change in a PR will be deployed and validated in the *CANARY* management group structure.

If approved it will be deployed to the *PRODUCTION* management group structure.

## How To

Prefer to use built-in policies or *steal* from <https://github.com/Azure/ALZ-Bicep/tree/main/infra-as-code/bicep/modules/policy/definitions/lib>.

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
