[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Path,

    [Parameter(Mandatory = $true)]
    [String]
    $ManagementGroupId
)

function Write-Compare ($Label, $Object, $SideIndicator, $Color, $Prefix) {
    $compare = $Object | Where-Object SideIndicator -eq $SideIndicator | ForEach-Object { "$Prefix $($PSItem.InputObject)" }
    if ($compare) {
        Write-Host $Label
        Write-Host $compare -Separator ([Environment]::NewLine) -ForegroundColor $Color
    }
    if ($compare -and $Prefix -eq "-") {
        Write-Host "##[warning]Delete detected. Manual intervention required."
        Write-Host "##vso[task.setvariable variable=deleteDetected]true"
    }
}

function Get-ResourceNameFromTemplate ($Path, $Pattern) {
    Get-ChildItem -Path $Path/*.bicep -Exclude deploy.bicep | ForEach-Object {
        $definition = $PSItem | Get-Content -Raw | Select-String -Pattern $Pattern
        $definition.Matches[0].Groups[1].Value
    }
}

function Compare-Item ($Label, $Path, $Pattern, $ManagementGroupId, $Command) {
    Write-Host "##[group]Comparing $($Label.ToLower()) under '$ManagementGroupId'..."

    $toBeDeployed = Get-ResourceNameFromTemplate -Path $Path -Pattern $Pattern
    $existing = Invoke-Expression -Command $Command | ConvertFrom-Json
    $compare = Compare-Object -ReferenceObject ($toBeDeployed ?? @()) -DifferenceObject ($existing ?? @()) -IncludeEqual

    Write-Compare -Label "##[section]$Label to be deleted:" -Object $compare -SideIndicator "=>" -Prefix "-" -Color Red
    Write-Compare -Label "##[section]$Label to be created:" -Object $compare -SideIndicator "<=" -Prefix "+" -Color Green
    Write-Compare -Label "##[section]$Label to be updated:" -Object $compare -SideIndicator "==" -Prefix "*" -Color Blue

    Write-Host "##[endgroup]"
}

Compare-Item -Label "Definitions" `
    -Path $Path/definitions `
    -ManagementGroupId $ManagementGroupId `
    -Pattern "=\s+\{\s+name:\s+'(.+)\'" `
    -Command "az policy definition list --management-group $ManagementGroupId --query `"[?policyType=='Custom'].name`""

Compare-Item -Label "Initiatives" `
    -Path $Path/initiatives `
    -ManagementGroupId $ManagementGroupId `
    -Pattern "=\s+\{\s+name:\s+'(.+)\'" `
    -Command "az policy set-definition list --management-group $ManagementGroupId --query `"[?policyType=='Custom'].name`""

Get-ChildItem -Path $Path/assignments -Directory -Recurse | Sort-Object -Property FullName | ForEach-Object {
    $managementGroupId = $PSItem.BaseName
    Compare-Item -Label "Assignments" `
        -Path $PSItem `
        -ManagementGroupId $managementGroupId `
        -Pattern "policyAssignmentName:\s+'(.+)\'" `
        -Command "az policy assignment list --scope '/providers/Microsoft.Management/managementGroups/$managementGroupId' --query '[].name'"
}
