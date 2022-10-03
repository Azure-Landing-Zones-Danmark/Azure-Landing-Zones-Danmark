<#
.DESCRIPTION
Script will remove all management groups in tenant(!)
#>
[CmdletBinding()]
param ()

$tenantId = (Get-AzContext).Tenant.Id

Get-AzManagementGroup | Where-Object Name -ne $tenantId | ForEach-Object {
    $group = $PSItem
    Get-AzManagementGroupSubscription -GroupName $group.Name | ForEach-Object {
        $subscriptionId = $PSItem.Id -split "/" | Select-Object -Last 1
        Write-Verbose "Moving subscription $($PSItem.DisplayName) to /"
        New-AzManagementGroupSubscription -GroupName $group.TenantId -SubscriptionId $subscriptionId
    }
}

$queue = New-Object -TypeName "System.Collections.Queue"

Get-AzManagementGroup | Where-Object Name -ne $tenantId | ForEach-Object {
    $queue.Enqueue($PSItem.Name)
}

while ($queue.Count) {
    Write-Verbose "Queue: $($queue.Count)..."
    $name = $queue.Dequeue()
    $group = Get-AzManagementGroup -GroupName $name -Expand
    $displayName = $group.DisplayName
    Write-Verbose "Checking management group $displayName..."
    if ($group.Children) {
        $queue.Enqueue($name)
    }
    else {
        Write-Verbose "Removing management group $displayName..."
        Remove-AzManagementGroup -GroupName $name
    }
}
