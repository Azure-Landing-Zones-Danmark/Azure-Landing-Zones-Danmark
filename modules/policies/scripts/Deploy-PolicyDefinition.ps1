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

var policyDefinitions = [
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

resource policyDefinitionResources 'Microsoft.Authorization/policyDefinitions@2021-06-01' = [for definition in policyDefinitions: {
  name: definition.name
  properties: definition.properties
}]
"@
    }
}

$template = Join-Path -Path (Get-Item -Path $Path) -ChildPath ".deploy.bicep"
Get-ChildItem -Path "$Path/*.json" | Join-Template | Set-Content -Path $template -WhatIf:$false

New-AzManagementGroupDeployment -Name "policy-definitions" -ManagementGroupId $ManagementGroupId -Location $Location -TemplateFile $template
