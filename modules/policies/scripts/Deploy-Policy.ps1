[CmdletBinding(SupportsShouldProcess = $true)]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Path,

    [Parameter(Mandatory = $true)]
    [String]
    $Location,

    [Parameter(Mandatory = $true)]
    [String]
    $ManagementGroupRoot,

    [Parameter(Mandatory = $true)]
    [ValidateSet("canary", "prod")]
    [String]
    $Environment
)

if ($WhatIfPreference) {
    $action = "what-if"
    $WhatIfPreference = $false
}
else {
    $action = "create"
}

function Join-Template {
    [CmdletBinding()]
    [OutputType([String])]
    param ([Parameter(ValueFromPipeline = $true)][String[]]$Path)
    begin {
        "targetScope = 'managementGroup'"
        $params = @()
    }
    process {
        $params += (Get-Content -Path $Path | Where-Object { $PSItem -match "^param " })
        Get-Content -Path $Path | Where-Object { $PSItem -ne "targetScope = 'managementGroup'" -and $PSItem -notmatch "^param " }
    }
    end {
        $params | Select-Object -Unique
    }
}

function Get-Parameter ($Path, $Environment) {
    if (Test-Path -Path "$Path/.$Environment.params.json") {
        $parameters = Resolve-Path -Path "$Path/.$Environment.params.json" -Relative
        "@$parameters"
    }
}

function Deploy-Template ($Path, $ManagementGroupId, $Location, $DeploymentName, $Environment) {
    $template = Join-Path -Path (Get-Item -Path $Path) -ChildPath "deploy.bicep"
    Get-ChildItem -Path $Path/*.bicep -Exclude deploy.bicep | Join-Template | Set-Content -Path $template
    if ($parameters = Get-Parameter -Path $Path -Environment $Environment -or $DeploymentName -eq "policy-assignments") {
        if ($DeploymentName -eq "policy-assignments") {
            $managementGroupParameter = "managementGroupId=$ManagementGroupId"
        }
        if ($action -eq "create") {
            (az deployment mg create --name $DeploymentName --management-group-id $ManagementGroupId --location $location --template-file $template --parameters $parameters $managementGroupParameter --only-show-errors)
        }
        elseif ($action -eq "what-if") {
            (az deployment mg what-if --name $DeploymentName --management-group-id $ManagementGroupId --location $location --template-file $template --parameters $parameters $managementGroupParameter --result-format ResourceIdOnly --only-show-errors)
        }
    }
    else {
        if ($action -eq "create") {
            (az deployment mg create --name $DeploymentName --management-group-id $ManagementGroupId --location $location --template-file $template --only-show-errors)
        }
        elseif ($action -eq "what-if") {
            (az deployment mg what-if --name $DeploymentName --management-group-id $ManagementGroupId --location $location --template-file $template --result-format ResourceIdOnly --only-show-errors)
        }
    }
    Remove-Item -Path $template
}

function Deploy-TemplateRecursive ($Path, $ManagementGroupRoot, $Location, $Environment) {
    Write-Verbose -Message "Deploying policy assignments to '$ManagementGroupRoot'"
    Deploy-Template -Path $Path -ManagementGroupId $ManagementGroupRoot -Location $Location -DeploymentName "policy-assignments"

    Get-ChildItem -Path $Path -Recurse -Directory | Sort-Object -Property FullName | ForEach-Object {
        $managementGroupId = "$ManagementGroupRoot-$($PSItem.BaseName)"
        Write-Verbose -Message "Deploying policy assignments to '$managementGroupId'"
        Deploy-Template -Path $PSItem -ManagementGroupId $managementGroupId -Location $Location -DeploymentName "policy-assignments"
    }
}

Write-Verbose -Message "Deploying policy definitions to '$ManagementGroupRoot'"
Deploy-Template -Path $Path/definitions -ManagementGroupId $ManagementGroupRoot -Location $Location -DeploymentName "policy-definitions" -Environment $Environment

Write-Verbose -Message "Deploying initiatives to '$ManagementGroupRoot'"
Deploy-Template -Path $Path/initiatives -ManagementGroupId $ManagementGroupRoot -Location $Location -DeploymentName "initiatives" -Environment $Environment

Deploy-TemplateRecursive -Path $Path/assignments -ManagementGroupRoot $ManagementGroupRoot -Location $Location -Environment $Environment
