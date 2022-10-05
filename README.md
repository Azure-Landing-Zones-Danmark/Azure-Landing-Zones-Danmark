# Azure-Landing-Zones-Danmark

[![GitHub Super-Linter](https://github.com/Azure-Landing-Zones-Danmark/Azure-Landing-Zones-Danmark/actions/workflows/linter.yml/badge.svg)](https://github.com/marketplace/actions/super-linter)

[![en](https://img.shields.io/badge/lang-en-red.svg)](README.md)
[![en](https://img.shields.io/badge/lang-da--dk-green.svg)](README.da-dk.md)

## Repository for the Danish Azure Landing Zone accelerator

```txt
 _____                                   _               _      ______
|  __ \                                 | |        /\   | |    |___  /
| |  | | __ _ _ __  _ __ ___   __ _ _ __| | __    /  \  | |       / /
| |  | |/ _` | '_ \| '_ ` _ \ / _` | '__| |/ /   / /\ \ | |      / /
| |__| | (_| | | | | | | | | | (_| | |  |   <   / ____ \| |____ / /__
|_____/ \__,_|_| |_|_| |_| |_|\__,_|_|  |_|\_\ /_/    \_\______/_____|

```

This is a landing page and is still work in progress!

This project will provide:

- a repository of Azure Policies to create the foundation for a compliant Azure Landing Zone in a Danish context using the principles of [Policy-Driven-Governance](https://learn.microsoft.com/en-gb/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance)
- A [Security Control Mapping Process](docs/SecurityControlMapping.md) to map every deployable Azure Policy back to a regulatory or organizational requirement and to ensure the mapping process has a owner

## Guiding principles

1. Stakeholder mapping: Security Control Mapping is a continuous process and requires clear organizational ownership fo Compliance Domains, Policy application, Compliance reporting and remediation.

1. All Policies mus be mapped to a requirement in the form of a Compliance domain and Control

1. Azure Policy must be under source control, managed using DevOps principals and deployed via a CI/CD process

1. This project builds on and is aligned to [Azure Landing Zones](https://github.com/Azure/Enterprise-Scale). The aim of this project is to provide solution accelerator for Danish Customers in regulated Industries

## Implementation options

The current repository is built using Bicep

- Support for Terraform will be added later
- The current repository is deployed using GitHub actions, support for Azure pipelines will be added later
