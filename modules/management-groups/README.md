# Management Groups Module

This module deploys the management group structure.

- Make sure to understand and review the naming structure of the Management Groups in the [Bicep file](./resources.bicep). If this is a Brownfield deployment then the hierarchy should be aligned to existing Management Group design

- understand testing approaches using [Canary Testing](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)

- Review the parameter files for [Canary](../../environments/canary/management-groups.parameters.json) and [Prod](../../environments/prod/management-groups.parameters.json)

## Manual Management Group Deployment for testing

login to AZ CLI before use:

```bash

    az login --tenant 'XXXXXXXX-XXXXX-XXXX-XXXX-XXXXXXXXXXXX'

```

upgrade AZ CLI to get the latest bicep version before use

```bash

    az upgrade

```

Set Permissions - (requires global admin). Make sure to [elevate permission first](https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin)

```bash

    az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2016-07-01"

```

---
**NOTE**

if you have elevated your permissions you will need to run AZ LOGIN again

---

assign root permissions to service principal deploying at the tenant scope:

```bash

    $userid = az ad user list --upn 'upn@email.com' --query [].id --output tsv
    az role assignment create --assignee $userid --scope "/" --role "Owner"

```

Deploy Canary Management Group Structure:

```bash

    # deploy canary management group
    az deployment tenant create `
    --name management-groups `
    --template-file .\modules\management-groups\resources.bicep `
    --parameters .\environments\canary\management-groups.parameters.json `
    --location $location

```

Deploy Prod Management Group Structure

```bash

    # deploy prod management group
    az deployment tenant create `
    --name management-groups `
    --template-file .\modules\management-groups\resources.bicep `
    --parameters .\environments\prod\management-groups.parameters.json `
    --location $location

```