# Hackathon Hints

## Team 1

LT-3 enables "Diagnostic Settings" logs. Log to a common Log Analytics workspace for event types which would be valuable for a central Audit/Compliance function. This would not include metrics. Would the metrics and all other event types be useful for the application team to retain within their Log Analytics workspace? How could you configure 2 types of settings enforcement? Are all resource types with "Diagnostic Settings" addressed?

ES-1 relates to deploying Defender for Endpoints to servers. Should you also consider AKS nodes? Containers or other types of compute? Where do you draw the line between this policy and one for other services?

## Team 2

BR-1 and BR-2 both require the same enforcement, i.e. Enable managed backups on all services where this is possible. Look for additional services where backup can be DINE'ed by policy.

Also investigate at multi-user authentication for Resource Guard in Azure Backup and check if this can also be enforced by policy.

PA-4: Perhaps this can be solved by using a constantly repeating "clobber" action from DevOps to always override any RBAC not defined in a central RBAC definition table.

## Team 3

IM-1: there are more services where AAD can be enforced for data plane activities

IM-3: there are more services where Managed Identity can be enabled

(DevOps - DP-6 requires shifting security left. This is better handled in the DevOps tool chain than in the Azure Platform so it will be excluded from this exercise)

## Team 4

DP-5: Customer Managed Keys are seen as a popular mitigation for data sovereignty risks. Are there additional services which could also be enforced to require CMK? Some services can automatically roll their CMKs stored in Key Vault without interrupting operations. Can this be enforced?

IR-3 and IR-5 both require the same enforcement. Investigate if other services can be enabled for Defender.

## Team 5

Choose to complete either NS-2 and NS-8 or AM-2

NS-2 would be useful on "CORP" landing zones where 2 actions need to happen on all deployed resources with public endpoints; 1) remove the public endpoint or enable the public endpoint firewall for the service, 2) ensure the service is deployed with a private endpoint enabled. Assume that the Landing Zone was provisioned with a VNET. Also investigate if are there additional services which can use private endpoints.

NS-8 requires at least TLS 1.2. Are there any other endpoint types which can enforce a specific TLS version?

AM-2 states that "only approved cloud services can be used, by auditing and restricting which services users can provision in the environment." Many organizations in Demark are affected by a legal compliance requirement that requires them to only use "Core Online Services", defined by this list: <https://www.microsoft.com/licensing/terms/product/PrivacyandSecurityTerms/EAEAS>.

Investigate of you can construct a policy which denies creating services from Resource Providers not contained in this list.

Other organizations in Denmark must only allow data to reside in the EU. Consider creating a policy which denies creating resources in regions which are not located in the EU. This may also include "global" resources like CDN, Front Door, Azure DNS etc.
