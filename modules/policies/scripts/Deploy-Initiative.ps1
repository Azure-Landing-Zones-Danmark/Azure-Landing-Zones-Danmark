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
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "", Justification = "False positive")]
    [CmdletBinding()]
    [OutputType([String])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Object[]]
        $Path,

        [Parameter(Mandatory = $true)]
        [String]
        $ManagementGroupId
    )

    begin {
        @"
targetScope = 'managementGroup'

var initiatives = [
"@
    }

    process {
        $Path | ForEach-Object {
            (Get-Content -Path $Path -Raw) -replace "<prefix>", $ManagementGroupId | Set-Content -Path $Path
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
Get-ChildItem -Path "$Path/*.json" | Join-Template -ManagementGroupId $ManagementGroupId | Set-Content -Path $template -WhatIf:$false

New-AzManagementGroupDeployment -Name "initiatives" -ManagementGroupId $ManagementGroupId -Location $Location -TemplateFile $template
