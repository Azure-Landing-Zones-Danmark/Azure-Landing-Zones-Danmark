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
        Resolve-Path -Path "$Path/.$Environment.params.json"
    }
    else {
        Resolve-Path -Path "$PSScriptRoot/template.params.json"
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

    $template = Join-Path -Path (Get-Item -Path $Path) -ChildPath ".deploy.bicep"
    Get-ChildItem -Path $Path/*.bicep -Exclude ".deploy.bicep" | Join-Template -ManagementGroupId $ManagementGroupId | Set-Content -Path $template -WhatIf:$false
    $parameters = Get-Parameter -Path $Path -Environment $Environment
    New-AzManagementGroupDeployment -Name $DeploymentName -ManagementGroupId $ManagementGroupId -Location $Location -TemplateFile $template -TemplateParameterFile $parameters
    Remove-Item -Path $template -WhatIf:$false
}

function Get-AssignmentGroups {
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Path,

        [Parameter(Mandatory = $true)]
        [String]
        $ManagementGroupRoot
    )

    $assignments = Get-ChildItem -Path $Path -Directory -Recurse | Sort-Object -Property FullName
    $root = Get-Item -Path $Path
    $assignments = $assignments += $root
    $assignments | Sort-Object FullName | ForEach-Object {
        @{
            Path              = $PSItem.FullName
            ManagementGroupId = $PSItem.FullName.Replace($root.FullName, $ManagementGroupRoot) -replace "[\\/]", "-"
        }
    }
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

    Get-AssignmentGroups -Path $Path -ManagementGroupRoot $ManagementGroupRoot | ForEach-Object {
        $path = $PSItem.Path
        $managementGroupId = $PSItem.ManagementGroupId
        Write-Verbose -Message "Deploying policy assignments to '$managementGroupId'"
        Deploy-Template -Path $path -ManagementGroupId $managementGroupId -Location $Location -DeploymentName "policy-assignments" -Environment $Environment
    }
}

Write-Verbose -Message "Deploying policy definitions to '$ManagementGroupRoot'"
Deploy-Template -Path $Path/definitions -ManagementGroupId $ManagementGroupRoot -Location $Location -DeploymentName "policy-definitions" -Environment $Environment

Write-Verbose -Message "Deploying initiatives to '$ManagementGroupRoot'"
Deploy-Template -Path $Path/initiatives -ManagementGroupId $ManagementGroupRoot -Location $Location -DeploymentName "initiatives" -Environment $Environment

Deploy-TemplateRecursive -Path $Path/assignments -ManagementGroupRoot $ManagementGroupRoot -Location $Location -Environment $Environment
