[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Path,

    [Parameter(Mandatory = $true)]
    [String]
    $ManagementGroupId
)

function Write-Compare ($Label, $Object, $SideIndicator, $Prefix) {
    $compare = $Object | Where-Object SideIndicator -eq $SideIndicator | ForEach-Object { "$Prefix $($PSItem.InputObject)" }
    if ($compare) {
        Write-Output $Label
        Write-Output $compare
    }
}

function Get-ResourceNameFromTemplate ($Path, $Pattern) {
    Get-ChildItem -Path "$Path/*.json" | ForEach-Object {
        $template = $PSItem | Get-Content | ConvertFrom-Json
        $template.name
    }
}

function Compare-Item ($Source, $Cloud, $Label, $ManagementGroupId) {
    Write-Output "Comparing initiatives under '$ManagementGroupId'..."
    $compare = Compare-Object -ReferenceObject ($Cloud ?? @()) -DifferenceObject ($Source ?? @()) -IncludeEqual
    Write-Compare -Label "Initiatives to be created:" -Object $compare -SideIndicator "=>" -Prefix "+"
    Write-Compare -Label "Initiatives to be updated:" -Object $compare -SideIndicator "==" -Prefix "*"
    Write-Compare -Label "Initiatives to be deleted:" -Object $compare -SideIndicator "<=" -Prefix "-"

    if ($compare | Where-Object SideIndicator -EQ "<=") {
        Write-Output "::set-output name=DELETE_DETECTED::true"
    }
}

$cloud = Get-AzPolicySetDefinition -ManagementGroupName $ManagementGroupId -Custom |
Where-Object ResourceId -Match "^/providers/Microsoft.Management/managementGroups/$ManagementGroupId/" |
Select-Object -ExpandProperty Name

$source = Get-ResourceNameFromTemplate -Path $Path -Pattern "resource .+ 'Microsoft.Authorization/policySetDefinitions@.+' = \{\s+name: '(.+)'"
Compare-Item -Source $source -Cloud $cloud -ManagementGroupId $ManagementGroupId
