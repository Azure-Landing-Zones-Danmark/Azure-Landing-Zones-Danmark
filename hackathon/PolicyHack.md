# Azure-Landing-Zones-Danmark Hackathon

---
&nbsp;
&nbsp;

## Prerequisites

- a laptop or PC to develop and commit code
- a Github ID
- Visual Studio Code

---
&nbsp;
&nbsp;

## Housekeeping


- Create your own branch of this repository - don´t work directly from the main branch
- submit pull requests to comit your changes back to the main branch
- you will have a Read Only account to the Test Azure Environment - everythinng must be deployed via Service Principle and CI/CD pipeline
- For every Policy assignment consider how to handle exception
- For every Policy assignment created consider how to support the [Canary Management Group stucture](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)
- Collect the feedback from the [Security Control Mapping process](../docs/Danmark-azure-security-benchmark-v3.0.xlsx). This will provide 

---
&nbsp;
&nbsp;

## Hackathon challenges

You will be split into groups and can voulunteer to accept any of the following challenges. Alternatively you can agree your own challenge with the group using the outcome of the [Security Control Mapping process](../docs/Danmark-azure-security-benchmark-v3.0.xlsx)

---
&nbsp;

1. Create the Management Group structure

    - Clone this repository into your and run the pipeline to create the Management Group structure
    - Make sure the naming convention of the Management Groups (especially the psuedo-root group) matches your organisation name
    - Make sure to consider how to use the [Canary Management Group stucture](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)

---
&nbsp;
&nbsp;
&nbsp;

2. Deploy Azure Security Baseline

    - Create an Azure DevOps pipeline that assigns the Azure Security Baseline at the Pseudo root Group

---
&nbsp;
&nbsp;
&nbsp;

3. Azure Defender for Cloud

    - Create an initative, assignment and Azure Pipeline that deploys and configures Azure Defender for Cloud

---
&nbsp;
&nbsp;
&nbsp;

4. Diagnostic Settings

    - create initative, assignment and Azure Pipeline that deploys and configures Diagnostics Settings
    - is there a need for custom policies
    - are these settings covered in other initiatives

---
&nbsp;
&nbsp;
&nbsp;

5. HSM, Key Vault and Cryptography for Confidential Landing Zones

    - create initative, assignment and Azure Pipeline that deploys and configures Key Vault
    - What are the requirements for Configdental / Sovereign / National Security workloads
    - What policies do we need for [Azure Managed HSM](https://learn.microsoft.com/en-us/azure/key-vault/managed-hsm/overview) ?

---
&nbsp;
&nbsp;
&nbsp;


6. Deploy ESLZ custom policy

    - Create a CI/CD pipeline that creates the ESLZ custom policy defintions and policy defintion sets
    - pay attention to where the policy is created in the Management Group hierachy

---
&nbsp;
&nbsp;
&nbsp;

7. Create Custom Policies (Audit, DINE, Append, Modify, Deny?)

    - use the outcome of the [Security Control Mapping process](../docs/Danmark-azure-security-benchmark-v3.0.xlsx) to create custom Azure Policy
    - document the versioning process for custom policies

---
&nbsp;
&nbsp;
&nbsp;


8. Create CI/CD Pipelines to create and assign new Policy initatives

    - implement a staged approval, test and deployment process using [Canary Management Group principals](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)
    - include a process for documenting, reviewing and [Azure Policy exemptions](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure)
    - include a process for updating, chaging or removing Poiliy assignments
    - include a process for updating, chaging or removing Policy assignments

---
&nbsp;
&nbsp;
&nbsp;


9. Write the code to create [Remediation Tasks](https://learn.microsoft.com/en-us/azure/governance/policy/how-to/remediate-resources?tabs=azure-portal) for non compliant Azure Resource
    - create a repeatable process for remeidiating non-copliant Azure resources via a CI/CD pipeline

---
&nbsp;
&nbsp;
&nbsp;


10. Create a process to create [Governance Rules in Microsoft Defender for cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/governance-rules)
    - investigate how to assign owners and deadlines programtically based on [resource tags or subscription tags](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=json)
    - create a repeatable process that can integrate into a CI/CD pipeline

---
&nbsp;
&nbsp;
&nbsp;


11. Reporting
    - investigate the [reporting options](https://learn.microsoft.com/en-us/azure/governance/policy/how-to/get-compliance-data) for non-compliant resources via dashboards or other methods

