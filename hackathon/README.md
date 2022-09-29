# Azure-Landing-Zones-Danmark Hackathon

## Prerequisites

- An Azure tenant to test the repo and pipelines - tenant wide permisson are required to deploy the Management Group Structure
- An Azure DevOps project with the ability to create Service Connections into your tenant
- Visual Studio Code

## Hackathon challenges

1. Create Management Groups

    - Clone this repo into your Azure DevOps project and run the pipeline to create the Management Group structure
    - Make sure the naming convention of the Management Groups (especially the psuedo-root group) matches your organisation name

1. Deploy ESLZ custom policy

    - Create a pipeline in Azure Devops that creates the ESLZ custo policy defintions and policy defintion sets in your tennant
    - pay attention to where the policy is created in the Management Group hierachy

1. Deploy Azure Security Baseline

    - Create an Azure DevOps pipeline that assigns the Azure Security Baseline at the Pseudo root Group

1. Azure Defender for Cloud

    - Create an initative, assignment and Azure Pipeline that deploys and configures Azure Defender for Cloud

1. Diagnostic Settings

    - create initative, assignment and Azure Pipeline that deploys and configures Diagnostics Settings
    - is there a need for custom policies

1. Key Vault

    - create initative, assignment and Azure Pipeline that deploys and configures Key Vault
    - What are the requirements for Configdental / Sovereign / National Security workloads
    - Do we need policies for HSM?

1. Storage

Work on more specific challenges:

- Create Custom Policies (Audit, DINE, Append, Modify, Deny?)
- Create Policy Initiative
- Deploy Policy definition
- Deploy Initiative
- Create Assignment (s)
- Exemptions
- Update / Modify Policy / Initiative / Assignment
- Remediation
