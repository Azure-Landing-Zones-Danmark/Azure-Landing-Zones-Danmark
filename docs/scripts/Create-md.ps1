# create .md file
$mdFile = '.\docs\Policies.md'
if(-not (Test-Path $mdFile)){New-Item -Name $mdFile}

# Add content to .md file

$PolicyHeader="
# Custom Policies

## The following custom policies are deployed to the 'lz-canary' and 'lz' Management Groups
"
Set-Content $mdFile $PolicyHeader

# document policies
$path = '.\modules\policies\definitions'

ForEach($policy in Get-ChildItem -Path $path){
    $displayName = Get-Content $path\$policy | Select-String -Pattern "displayName:*"
    [string]$strDisplayName = $displayName[0]
    $strDisplayName = $strDisplayName.Replace("displayName:","")

    $description = Get-Content $path\$policy | Select-String -Pattern "description:*"

    $filePath = "$path\$policy"
    $filePath = ($filePath.Replace(".\","")).Replace("\","/")

    Add-Content $mdFile "Display Name: [$strDisplayName]($filePath)  "
    Add-Content $mdFile $description[0]
    Add-Content $mdFile `n
}



# document initiatives

# create .md file
$mdFileInitiative = '.\docs\Initiatives.md'
if(-not (Test-Path $mdFileInitiative)){New-Item -Name $mdFileInitiative}

# Add content to .md file

$initiativeHeader="
# Custom Initatives

## The following custom initiatives are deployed to the 'lz-canary' and 'lz' Management Groups
"
Set-Content $mdFileInitiative $initiativeHeader

$initiativePath = '.\modules\policies\initiatives'


ForEach($initiative in Get-ChildItem -Path $initiativePath){
    $displayName = Get-Content $initiativePath\$initiative | Select-String -Pattern "displayName:*"
    [string]$strDisplayName = $displayName[0]
    $strDisplayName = $strDisplayName.Replace("displayName:","")

    $description = Get-Content $initiativePath\$initiative| Select-String -Pattern "description:*"

    $filePath = "$path\$policy"
    $filePath = ($filePath.Replace(".\","")).Replace("\","/")

    Add-Content $mdFileInitiative  "Display Name: [$strDisplayName]($filePath)  "
    Add-Content $mdFileInitiative  $description[0]

    $policyDefinitionReferenceIds = Get-Content $initiativePath\$initiative| Select-String -Pattern "policyDefinitionReferenceId:*"
    foreach($policyDefinitionReferenceId in $policyDefinitionReferenceIds){
        Add-Content $mdFileInitiative "- $policyDefinitionReferenceId"
    }
    Add-Content $mdFileInitiative  `n
}

# document assignments
# create .md file
$mdFileAssignments = '.\docs\Assignments.md'
if(-not (Test-Path $mdFileAssignments)){New-Item -Name $mdFileAssignments}

# Add content to .md file

$AssignmentHeader="
# Policy Assignments

## The following Policies and Initiatives are deployed to the 'lz-canary' and 'lz' Management Groups
"
Set-Content $mdFileAssignments $AssignmentHeader
$assignmentPath = '.\modules\policies\assignments'

ForEach($assignment in Get-ChildItem -Path $assignmentPath -Recurse -Depth 4 -Include "*.bicep"){
    $policyAssignmentName = Get-Content $assignment.FullName | Select-String -Pattern "policyAssignmentName:*"
    If($assignment.Directory.BaseName -eq "assignments"){$mgmtGrpName = "root"}
    else{$mgmtGrpName = $assignment.Directory.BaseName }
    Add-Content $mdFileAssignments "$policyAssignmentName is assigned to Management Group: $mgmtGrpName  "
    Add-Content $mdFileAssignments   `n
}
