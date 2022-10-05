[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Path,

    [Parameter(Mandatory = $true)]
    [String]
    $ManagementGroupRoot
)

function Write-Compare ([Parameter(Mandatory = $true)][String]$Label, $Object, $SideIndicator, $Prefix) {
    $deleted = $Object | Where-Object SideIndicator -eq $SideIndicator | ForEach-Object { "$Prefix $($PSItem.InputObject)" }
    if ($deleted) {
        Write-Output $Label
        Write-Output $deleted
    }
}

function Get-ResourceNameFromTemplate ($Path, $Pattern) {
    Get-ChildItem -Path $Path/*.bicep -Exclude ".deploy.bicep" | ForEach-Object {
        $definition = $PSItem | Get-Content -Raw | Select-String -Pattern $Pattern
        $definition.Matches[0].Groups[1].Value
    }
}

function Compare-Item ($Item, $Label, $Path, $Pattern, $ManagementGroupId) {
    Write-Output "Comparing $($Label.ToLower()) under '$ManagementGroupId'..."
    $toBeDeployed = Get-ResourceNameFromTemplate -Path $Path -Pattern $Pattern
    $deleted = Compare-Object -ReferenceObject ($toBeDeployed ?? @()) -DifferenceObject ($Item ?? @()) -IncludeEqual
    Write-Compare -Label "$Label to be created:" -Object $deleted -SideIndicator "<=" -Prefix "+"
    Write-Compare -Label "$Label to be updated:" -Object $deleted -SideIndicator "==" -Prefix "*"
    Write-Compare -Label "$Label to be deleted:" -Object $deleted -SideIndicator "=>" -Prefix "-"

    $deleted | Where-Object SideIndicator -EQ "=>"
}

function Get-AssignmentGroup {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "", Justification = "False positive")]
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Path,

        [Parameter(Mandatory = $true)]
        [String]
        $ManagementGroupRoot
    )

    $assignments = Get-ChildItem -Path "$Path/assignments" -Directory -Recurse | Sort-Object -Property FullName
    $root = Get-Item -Path "$Path/assignments"
    $assignments = $assignments += $root
    $assignments | Sort-Object FullName | ForEach-Object {
        @{
            Path              = $PSItem.FullName
            ManagementGroupId = $PSItem.FullName.Replace($root.FullName, $ManagementGroupRoot) -replace "[\\/]", "-"
        }
    }
}

$deleted = $false

$definitions = Get-AzPolicyDefinition -ManagementGroupName $ManagementGroupRoot -Custom | Select-Object -ExpandProperty Name
$deleted = $deleted -or (Compare-Item -Label "Definitions" -Item $definitions -Path "$Path/definitions" -ManagementGroupId $ManagementGroupRoot -Pattern "=\s+\{\s+name:\s+'(.+)\'")

$initiatives = Get-AzPolicySetDefinition -ManagementGroupName $ManagementGroupRoot -Custom | Select-Object -ExpandProperty Name
$deleted = $deleted -or (Compare-Item -Label "Initiatives" -Item $initiatives -Path "$Path/initiatives" -ManagementGroupId $ManagementGroupRoot -Pattern "=\s+\{\s+name:\s+'(.+)\'")

Get-AssignmentGroup -Path $Path -ManagementGroupRoot $ManagementGroupRoot | ForEach-Object {
    $path = $PSItem.Path
    $managementGroupId = $PSItem.ManagementGroupId
    $managementGroup = Get-AzManagementGroup -GroupName $managementGroupId
    $assignments = Get-AzPolicyAssignment -Scope $managementGroup.Id | Where-Object { $PSItem.Properties.Scope -eq $managementGroup.Id } | Select-Object -ExpandProperty Name
    $deleted = $deleted -or (Compare-Item -Label "Assignments" -Item $assignments -Path $path -ManagementGroupId $managementGroupId -Pattern "policyAssignmentName:\s+'(.+)\'")
}

$deleted
