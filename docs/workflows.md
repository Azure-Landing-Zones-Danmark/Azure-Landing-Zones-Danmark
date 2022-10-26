# GitHub Workflows

The following GitHub Workflows are implemented by this solution

## Linter

[linter.yaml](../.github/workflows/linter.yml)

code analysis for potential problems

## Management Groups

[management-groups.yml](../.github/workflows/management-groups.yml)

Deploys the [Management Group hierarchy](../modules/management-groups/README.md)

## Management

[management.yml](../.github/workflows/management.yml)

Deploys the [Management Resources](../modules/management/README.md)

## Policies

[policies.yml](../.github/workflows/policies.yml)

Deploys [custom policies, initiatives and assignments](../modules/policies/README.md)

## Policy Remediation

[policy-remediation.yml](../.github/workflows/policy-remediation.yml)

Runs a scheduled job to initiate policy remediation

## Dependabot

[dependabot.yml](../.github/dependabot.yml)

Runs GitHub Dependabot Security analysis

## Governance Rules

[governance-rules.yml](../.github/workflows/governance-rules.yml)

Creates Defender for Cloud Governance Rules to subscriptions