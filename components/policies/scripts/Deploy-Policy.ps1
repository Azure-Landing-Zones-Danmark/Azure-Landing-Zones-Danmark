[CmdletBinding(SupportsShouldProcess = $true)]
[OutputType([String])]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $Path,

    [Parameter(Mandatory = $true)]
    [String]
    $Location,

    [Parameter(Mandatory = $true)]
    [String]
    $ManagementGroupId,

    [Parameter(Mandatory = $true)]
    [ValidateSet("test", "prod")]
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
    if (Test-Path -Path "$Path/$Environment.params.json") {
        $parameters = Resolve-Path -Path "$Path/$Environment.params.json" -Relative
        "@$parameters"
    }
}

function Deploy-Template ($Path, $ManagementGroupId, $Location, $DeploymentName, $Environment) {
    $template = Join-Path -Path (Get-Item -Path $Path) -ChildPath "deploy.bicep"
    Get-ChildItem -Path $Path/*.bicep -Exclude deploy.bicep | Join-Template | Set-Content -Path $template
    if ($parameters = Get-Parameter -Path $Path -Environment $Environment) {
        if ($action -eq "create") {
            (az deployment mg create --name $DeploymentName --management-group-id $ManagementGroupId --location $location --template-file $template --parameters $parameters --only-show-errors)
        }
        elseif ($action -eq "what-if") {
            (az deployment mg what-if --name $DeploymentName --management-group-id $ManagementGroupId --location $location --template-file $template --parameters $parameters --result-format ResourceIdOnly --only-show-errors)
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

function Deploy-TemplateRecursive ($Path, $ManagementGroupId, $Location, $Environment) {
    Get-ChildItem -Path $Path -Recurse -Directory | Sort-Object -Property FullName | ForEach-Object {
        Write-Verbose -Message "Deploying policy assignments to '$($PSItem.BaseName)'"
        Deploy-Template -Path $PSItem -ManagementGroupId $ManagementGroupId -Location $Location -DeploymentName "policy-assignments"
    }
}

Write-Verbose -Message "Deploying policy definitions to '$ManagementGroupId'"
Deploy-Template -Path $Path/definitions -ManagementGroupId $ManagementGroupId -Location $Location -DeploymentName "policy-definitions" -Environment $Environment

Write-Verbose -Message "Deploying initiatives to '$ManagementGroupId'"
Deploy-Template -Path $Path/initiatives -ManagementGroupId $ManagementGroupId -Location $Location -DeploymentName "initiatives" -Environment $Environment

Deploy-TemplateRecursive -Path $Path/assignments -ManagementGroupId $ManagementGroupId -Location $Location -Environment $Environment
