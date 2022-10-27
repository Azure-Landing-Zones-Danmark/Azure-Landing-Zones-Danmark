[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Path,

    [Parameter(Mandatory = $true)]
    [String]
    $Prefix
)

function Write-Compare ([Parameter(Mandatory = $true)][String]$Label, $Object, $SideIndicator, $Prefix) {
    $compare = $Object | Where-Object SideIndicator -eq $SideIndicator | ForEach-Object { "$Prefix $($PSItem.InputObject)" }
    if ($compare) {
        Write-Output $Label
        Write-Output $compare
    }
}

function Get-ResourceNameFromTemplate ($Path, $Pattern) {
    Get-ChildItem -Path "$Path/*.bicep" -Filter "*.bicep" | Where-Object Name -NE ".deploy.bicep" | ForEach-Object {
        $name = $PSItem | Get-Content -Raw | Select-String -Pattern $Pattern
        $name.Matches.Groups[1].Value
    }
}

function Compare-Item ($Source, $Cloud, $Label, $ManagementGroupId) {
    Write-Output "Comparing $($Label.ToLower()) under '$ManagementGroupId'..."
    $compare = Compare-Object -ReferenceObject ($Cloud ?? @()) -DifferenceObject ($Source ?? @()) -IncludeEqual
    Write-Compare -Label "$Label to be created:" -Object $compare -SideIndicator "=>" -Prefix "+"
    Write-Compare -Label "$Label to be updated:" -Object $compare -SideIndicator "==" -Prefix "*"
    Write-Compare -Label "$Label to be deleted:" -Object $compare -SideIndicator "<=" -Prefix "-"

    if ($compare | Where-Object SideIndicator -EQ "<=") {
        Write-Output "::set-output name=DELETE_DETECTED::true"
    }
}

function Get-AssignmentGroup {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "", Justification = "False positive")]
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Path,

        [Parameter(Mandatory = $true)]
        [String]
        $Prefix
    )

    $assignments = Get-ChildItem -Path "$Path/assignments" -Directory -Recurse | Sort-Object -Property FullName
    $root = Get-Item -Path "$Path/assignments"
    $assignments = $assignments += $root
    $assignments | Sort-Object FullName | ForEach-Object {
        @{
            Path              = $PSItem.FullName
            ManagementGroupId = $PSItem.FullName.Replace($root.FullName, $Prefix) -replace "[\\/]", "-"
        }
    }
}

$cloud = Get-AzPolicyDefinition -ManagementGroupName $Prefix -Custom |
Where-Object ResourceId -Match "^/providers/Microsoft.Management/managementGroups/$Prefix/" |
Select-Object -ExpandProperty Name
$source = Get-ResourceNameFromTemplate -Path (Join-Path -Path $Path -ChildPath "definitions") -Pattern "resource .+ 'Microsoft.Authorization/policyDefinitions@.+' = \{\s+name: '(.+)'"
Compare-Item -Source $source -Cloud $cloud -Label "Definitions" -ManagementGroupId $Prefix

$cloud = Get-AzPolicySetDefinition -ManagementGroupName $Prefix -Custom |
Where-Object ResourceId -Match "^/providers/Microsoft.Management/managementGroups/$Prefix/" |
Select-Object -ExpandProperty Name
$source = Get-ResourceNameFromTemplate -Path (Join-Path -Path $Path -ChildPath "initiatives") -Pattern "resource .+ 'Microsoft.Authorization/policySetDefinitions@.+' = \{\s+name: '(.+)'"
Compare-Item -Source $source -Cloud $cloud -Label "Initiatives" -ManagementGroupId $Prefix

Get-AssignmentGroup -Path $Path -Prefix $Prefix | ForEach-Object {
    $path = $PSItem.Path
    $managementGroupId = $PSItem.ManagementGroupId
    $managementGroup = Get-AzManagementGroup -GroupName $managementGroupId
    $cloud = Get-AzPolicyAssignment -Scope $managementGroup.Id | Where-Object { $PSItem.Properties.Scope -eq $managementGroup.Id } | Select-Object -ExpandProperty Name
    $source = Get-ResourceNameFromTemplate -Path $path -Pattern "policyAssignmentName: '(.+)'"
    Compare-Item -Source $source -Cloud $cloud -Label "Assignments" -ManagementGroupId $Prefix
}
