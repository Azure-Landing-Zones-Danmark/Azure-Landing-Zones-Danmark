param (
    [Parameter(Mandatory = $true)]
    [String]
    $Prefix
)

#create an empty array to hold subscriptions
$subscriptions = @()
# Iterate Management Groups to get subscriptions
ForEach ($mgmtGrp in Get-AzManagementGroup) {

    #Filter Management Groups on Prefix
    If ($mgmtGrp.Name -match $Prefix) {

        # query Azure Graph for subscriptions in the management group and add them to the arry of subscriptions
        $query = "ResourceContainers | where type =~ 'microsoft.resources/subscriptions' |  mv-expand managementGroupParent = properties.managementGroupAncestorsChain | where managementGroupParent.name =~ '$($mgmtGrp.Name)'"
        $graphResult = Search-AzGraph -Query $Query -ManagementGroup $mgmtGrp.Name -First 200
        if (($graphResult.count -gt 0) -and ( $graphResult.properties.state -eq 'enabled')) { $subscriptions += $graphResult.subscriptionid }
    }
}

# clean array to get unique subscriptions
$subscriptions = $subscriptions | select-object -Unique

# iterate Subscriptions to check for existing Governance Rules, and if missing, create new
foreach ($subscription in $subscriptions) {
    # query to see if a Goverance rule already exists
    write-output "checking $subscription for existing governance rules"

    $govRuleQuery = 'securityresources | where type == "microsoft.security/governancerules" '
    $govResult = Search-AzGraph -Query $govRuleQuery -Subscription $subscription -First 200

    #$govResult = Search-AzGraph -Query $govRuleQuery -Subscription 6a509a0a-f0b6-4e8c-88d3-7108d0f37309
    $existingGovRule = $false

    if ($govResult.count -gt 0) {
        foreach ($govRes in $govResult) {
            write-output "Goverance Rule $($govRes.Properties.displayName) found for $subscription"

            #Check to see if existing Governance rule is OK, or if we need to create a new one
            if (
                ($govRes.properties.governanceEmailNotification.disableManagerEmailNotification -eq $false) `
                    -and `
                ($govRes.properties.governanceEmailNotification.disableOwnerEmailNotification -eq $false) `
                    -and `
                ($govRes.properties.isDisabled -eq $false)  `
                    -and `
                ([mailaddress]$govRes.properties.ownerSource.value) `
                    -and `
                ($govRes.properties.ruleType -eq 'Integrated') `
                    -and `
                ($govRes.properties.sourceResourceType -eq 'Assessments')
            ) {
                # if existing rule matches above criteria then we don't need to create a new one, set variable to $true
                $existingGovRule = $true
            }
        }
    }
    if (($govResult.count -eq 0) -or ($existingGovRule -eq $false)) {
        # deploy new Governance rule
        write-output "New Governance Rules will be created for subscription: $subscription"

        # get subscription tags
        $tags = Get-AzTag -ResourceId /subscriptions/$subscription
        $owner = $tags.Properties.TagsProperty."owner"
        If (($owner) -or ([mailaddress]$owner)) {
            write-output "valid owner email adress $owner found for subscription $subscription"
            $deploymentParameters = @{
                disableManagerEmailNotification = $false
                disableOwnerEmailNotification   = $false
                description                     = "Governance Rule for subscription : $subscription"
                displayName                     = "Governance Rule for subscription : $subscription"
                isDisabled                      = $false
                isGracePeriod                   = $true
                ownerSourceType                 = "Manually"
                ownerSourceValue                = $owner
                remediationTimeFrame            = "7.00:00:00" #default 7 days
                rulePriority                    = 100
                ruleType                        = 'Integrated'
                sourceResourceType              = 'Assessments'

            }

            $parameters = @{
                templateFile            = '.\modules\shared\governance-rules.bicep'
                templateParameterObject = $deploymentParameters
                location                = 'WestEurope'
            }

            #select azure subscription to deploy into
            Select-AzSubscription -Subscription $subscription

            #deploy Governance Rule Bicep
            New-AzDeployment @parameters -Verbose
        }
        else { write-error "could not find a valid email address from the owner tag for subscription: $subscription" }
    }
}
