# Azure-Landing-Zones-Danmark

[![en](https://img.shields.io/badge/lang-en-red.svg)](README.md)
[![dk](https://img.shields.io/badge/lang-da--dk-green.svg)](README.da-dk.md)

[![License](https://img.shields.io/badge/License-MIT-green)](https://github.com/Azure-Landing-Zones-Danmark/Azure-Landing-Zones-Danmark/blob/main/LICENSE)
[![CodeOfConduct](https://img.shields.io/badge/Code--of--conduct-MS--Open--Source-red)](https://github.com/Azure-Landing-Zones-Danmark/Azure-Landing-Zones-Danmark/blob/main/CODE-OF-CONDUCT.md)

## Repository for a danish Azure Landing Zone accelerator - **DataOps section**

![Heading](../docs/images/azure-danmark-alz.jpg)

This is a landing page for **dataops** and is still work in progress!

This part of the project will provide:

- a repository of *Azure Policies* that can be used to create the foundation for a compliant *Azure Landing Zone* with special focus of data.
- Guidelines to the usage of data within different environments.
- the data element be used as an example is a *Personal record* containing CPR number (danish personal identifier), first name, last name and address information

## Guiding principles

1. **GDPR** rules must be adhered to

1. Data can only be used in the context of which they are collected

1. Development **can not** be done on production data



## Requirements

### Environment description

To control the policies, we need to know which environment we are working in. Overall, this document works with 4 environments:

- Sandbox – environment used to test functionality in a given service. These environments do NOT contain any business/company data.
- Non-Production – environments that contain development, qa and test scenarios organized in project rooms (see below)
- Production – environments supporting pre-prod and prod scenarios
- Confidential – environments supporting data processing of highly confidential data.

### Data classification lookup “database”

A “database” where we can do lookups to find out if a given asset requires special treatment – see Data Establishment.

## Environments and policies

In the different environments certain politics regarding encryption should be enforced.

|Environment/Policy|Sandbox|Non-Production|Production|Confidential|
|---|---|---|---|---|
|Encryption at Rest|Audit|Audit|Required|Required|
|Encryption in Transit|Audit|Audit|Required|Required|
|Encryption in Processing|N/A|N/A|N/A|Required|

- Audit – it is required that a policy audit if encryption is in place but does not require it. This can be used for risk-assessment.
- Required – the policy will prevent creating data storage of any kind without encryption.
- N/A – Not applicable

## Environments and Tags ##

In the different environments different tags are used to identify the nature of environment.

|Environment/Tag|Sandbox|Non-Production|Production|Confidential|Values|
|---|---|---|---|---|---|
|Data-owner|N/A|Required|Required|Required|*name of owner*|
|Environment|Required|Required|Required|Required|Sandbox, Non-Prod, Prod, Conf|
|Environment-type|N/A|Required|Required|Required|NonProd: Dev,Test,QA / Prod: PreProd,Prod|

- Audit – it is required that a policy audit if encryption is in place but does not require it. This can be used for risk-assessment.
- Required – the policy will prevent creating data storage of any kind without encryption.
- N/A – Not applicable

## Data Establishment ##

Project room as an isolated environment with AD-Group ownership.

Possible to make data sources brought into the project room read-only

The process of bringing Data into the project room is one (or more) of the following:

- Copy of production data
- Data generation of fake data
- Anonymization
- Pseudonymization
- Encryption + *Dictionary*
- *“No relations”* datasets

The process being used will depend on the classification of the different data elements.

## Data processing in detail ##

### Copy of production data ###
### Data generation of fake data ###
### Anonymization ###
### Pseudonymization ###
### Encryption + *Dictionary* ###
### *“No relations”* datasets ###
