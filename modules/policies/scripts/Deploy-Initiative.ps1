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
    $ManagementGroupId
)

function Join-Template {
    [CmdletBinding()]
    [OutputType([String])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String[]]
        $Path
    )

    begin {
        @"
targetScope = 'managementGroup'

var initiatives = [
"@
    }

    process {
        $Path | ForEach-Object {
            "  loadJsonContent('$PSItem')"
        }
    }

    end {
        @"
]

resource initiativeResources 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = [for initiative in initiatives: {
  name: initiative.name
  properties: initiative.properties
}]
"@
    }
}

$template = Join-Path -Path (Get-Item -Path $Path) -ChildPath ".deploy.bicep"
Get-ChildItem -Path $Path/*.bicep -Exclude ".deploy.bicep" | Join-Template -ManagementGroupId $ManagementGroupId | Set-Content -Path $template -WhatIf:$false

New-AzManagementGroupDeployment -Name $DeploymentName -ManagementGroupId $ManagementGroupId -Location $Location -TemplateFile $template -TemplateParameterFile $parameters
