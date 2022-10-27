# Governance Rules

This module deploys Azure Defender for cloud [Governance Rules](https://learn.microsoft.com/en-us/azure/defender-for-cloud/governance-rules) into all subscriptions that have the 'owner' tag defined as a valid email address.

Governance Rules are a preview feature (as of 27/10/2022), therefore the [GitHub action](../../.github/workflows/governance-rules.yml) that deploys them is set to disabled.  To enable, uncomment the schedule:

```yaml
on:  # yamllint disable-line rule:truthy
  push:
    branches:
      - none
  # schedule:
  #  - cron: 0 0 * * sun #every sunday at 00.00

  ```

To test the script manually via Powershell run:

```powershell
Deploy-GovernanceRules.ps1 -prefix 'lz-canary'
```
