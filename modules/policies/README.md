# Policy Framework Component

This contains a folder structure which mimics how policy definitions and assignments are deployed to the management group structure.

All definitions and initiatives are deployed to the root management group.

All definitions, initiatives, and assignments are built using atomic management group level templates written i *bicep*.

## Phased Rollout Strategy - Continuous Deployment

A policy change in a PR will be deployed and validated in the *TEST* tenant.

If approved it will be deployed to the *PRODUCTION* tenant.

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
