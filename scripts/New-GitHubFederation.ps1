<#
        .SYNOPSIS
        Creates a federated identity credential between Azure Active Directory and GitHub that can be used to run Github actions.

        .DESCRIPTION
        Creates a federated identity credential between Azure Active Directory and GitHub that can be used to run Github actions.
        This is the prefered approach as there are no secrets or keys to secure or rotate.
        See the following documents for more details:
        https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-powershell%2Cwindows#use-the-azure-login-action-with-openid-connect

        .EXAMPLE
        PS> New-GithubFerderation.ps1

        .EXAMPLE
        PS> New-GithubFerderation.ps1
#>

param (
    [String]
    $appName = "Matthew-Danmark-ALZ"

)

Connect-AzAccount -Tenant '4f8875af-ac0b-46ee-8a73-3634138f5818'

Install-Module -Name PowerShellGet -Scope CurrentUser -AllowClobber -Force
Install-Module -Name Az.Resources -AllowPrerelease -Scope CurrentUser -Force

# create the Azure AD application that will be used for federation
New-AzADApplication -DisplayName $appName


#Create a service principal using the appid from the Azure AD Application
$clientId = (Get-AzADApplication -DisplayName $appName).AppId
New-AzADServicePrincipal -ApplicationId $clientId

# create a federated identity credential on an app
$objectId = (Get-AzADApplication -DisplayName $appName).Id
New-AzADAppFederatedCredential -ApplicationObjectId $objectId -Audience api://AzureADTokenExchange -Issuer 'https://token.actions.githubusercontent.com/' -Name 'Matthew-Azure-Landing-Zones-Danmark-Production' -Subject 'repo:MatthewGrimshaw/Azure-Landing-Zones-Danmark:environment:Production'
New-AzADAppFederatedCredential -ApplicationObjectId $objectId -Audience api://AzureADTokenExchange -Issuer 'https://token.actions.githubusercontent.com/' -Name 'Matthew-Azure-Landing-Zones-Danmark-Canary' -Subject 'repo:MatthewGrimshaw/Azure-Landing-Zones-Danmark:environment:Canary'
New-AzADAppFederatedCredential -ApplicationObjectId $objectId -Audience api://AzureADTokenExchange -Issuer 'https://token.actions.githubusercontent.com/' -Name 'Matthew-Azure-Landing-Zones-Danmark-PR' -Subject 'repo:MatthewGrimshaw/Azure-Landing-Zones-Danmark:pull_request'
New-AzADAppFederatedCredential -ApplicationObjectId $objectId -Audience api://AzureADTokenExchange -Issuer 'https://token.actions.githubusercontent.com/' -Name 'Matthew-Azure-Landing-Zones-Danmark-Main' -Subject 'repo:MatthewGrimshaw/Azure-Landing-Zones-Danmark:ref:refs/heads/main'


# create a new role assignmnet - the service principal needs root contributor in order to be able to create the Management Group structure
$objectId = (Get-AzADServicePrincipal -DisplayName $appName).Id
New-AzRoleAssignment -ObjectId $objectId -RoleDefinitionName Contributor -Scope /


#Get the values for clientId, subscriptionId, and tenantId to use later in your GitHub Actions workflow.
$clientId = (Get-AzADApplication -DisplayName $appName).AppId
$subscriptionId = (Get-AzContext).Subscription.Id
$tenantId = (Get-AzContext).Subscription.TenantId

write-output "For GitHib secrets use:"
write-output "clientID: "           $clientId
write-output "subscriptionId: "     $subscriptionId
write-output "tenantId: "           $tenantId