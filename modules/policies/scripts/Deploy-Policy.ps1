[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression", "", Justification = "Required for AZ CLI. Consider switching to Azure PowerShell")]
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
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String[]]
        $Path,

        [Parameter(Mandatory = $true)]
        [String]
        $ManagementGroupId
    )

    begin {
        "targetScope = 'managementGroup'"
        $params = @()
    }

    process {
        $params += (Get-Content -Path $Path | Where-Object { $PSItem -match "^param " } | ForEach-Object { $PSItem -replace "^param managementGroupId string$", "param managementGroupId string = '$ManagementGroupId'" })
        Get-Content -Path $Path | Where-Object { $PSItem -ne "targetScope = 'managementGroup'" -and $PSItem -notmatch "^param " }
    }

    end {
        $params | Select-Object -Unique
    }
}

function Get-Parameter {
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Path,

        [Parameter(Mandatory = $true)]
        [String]
        $Environment
    )

    if (Test-Path -Path "$Path/.$Environment.params.json") {
        $parameters = Resolve-Path -Path "$Path/.$Environment.params.json" -Relative
        "--parameters @$parameters"
    }
}

function Deploy-Template {
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Path,

        [Parameter(Mandatory = $true)]
        [String]
        $ManagementGroupId,

        [Parameter(Mandatory = $true)]
        [String]
        $Location,

        [Parameter(Mandatory = $true)]
        [String]
        $DeploymentName,

        [Parameter(Mandatory = $true)]
        [String]
        $Environment
    )

    $template = Join-Path -Path (Get-Item -Path $Path) -ChildPath "deploy.bicep"
    Get-ChildItem -Path $Path/*.bicep -Exclude "deploy.bicep" | Join-Template -ManagementGroupId $ManagementGroupId | Set-Content -Path $template
    $parameters = Get-Parameter -Path $Path -Environment $Environment
    Write-Host "az deployment mg $action --name $DeploymentName --management-group-id $ManagementGroupId --location $location --template-file $template $parameters"
    Invoke-Expression -Command "az deployment mg $action --name $DeploymentName --management-group-id $ManagementGroupId --location $location --template-file $template $parameters"
    Remove-Item -Path $template
}

function Deploy-TemplateRecursive {
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Path,

        [Parameter(Mandatory = $true)]
        [String]
        $ManagementGroupRoot,

        [Parameter(Mandatory = $true)]
        [String]
        $Location,

        [Parameter(Mandatory = $true)]
        [String]
        $Environment
    )

    Write-Verbose -Message "Deploying policy assignments to '$ManagementGroupRoot'"
    Deploy-Template -Path $Path -ManagementGroupId $ManagementGroupRoot -Location $Location -DeploymentName "policy-assignments" -Environment $Environment

    Get-ChildItem -Path $Path -Recurse -Directory | Sort-Object -Property FullName | ForEach-Object {
        $managementGroupId = "$ManagementGroupRoot-$($PSItem.BaseName)"
        Write-Verbose -Message "Deploying policy assignments to '$managementGroupId'"
        Deploy-Template -Path $PSItem -ManagementGroupId $managementGroupId -Location $Location -DeploymentName "policy-assignments" -Environment $Environment
    }
}

Write-Verbose -Message "Deploying policy definitions to '$ManagementGroupRoot'"
Deploy-Template -Path $Path/definitions -ManagementGroupId $ManagementGroupRoot -Location $Location -DeploymentName "policy-definitions" -Environment $Environment

Write-Verbose -Message "Deploying initiatives to '$ManagementGroupRoot'"
Deploy-Template -Path $Path/initiatives -ManagementGroupId $ManagementGroupRoot -Location $Location -DeploymentName "initiatives" -Environment $Environment

Deploy-TemplateRecursive -Path $Path/assignments -ManagementGroupRoot $ManagementGroupRoot -Location $Location -Environment $Environment
