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
        [Object[]]
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
            $name = $PSItem.Name
            "  loadJsonContent('$name')"
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
Get-ChildItem -Path "$Path/*.json" | Join-Template | Set-Content -Path $template -WhatIf:$false

New-AzManagementGroupDeployment -Name "initiatives" -ManagementGroupId $ManagementGroupId -Location $Location -TemplateFile $template
