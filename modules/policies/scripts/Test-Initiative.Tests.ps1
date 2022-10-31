Describe "Test-Initiative" {
    $path = Resolve-Path "$PSScriptRoot/../initiatives"

    $testCases = Get-ChildItem -Path "$path/*.json" | ForEach-Object {
        @{
            Name     = $PSItem.FullName.Replace($path, "")
            FullName = $PSItem.FullName
            BaseName = $PSItem.BaseName
        }
    }

    It "<Name> is similar to file" -TestCases $testCases {
        $template = Get-Content -Path $FullName | ConvertFrom-Json

        $template.name | Should -Be $BaseName
    }

    It "<Name> is an initiative" -TestCases $testCases {
        $template = Get-Content -Path $FullName | ConvertFrom-Json

        $template.type | Should -Be "Microsoft.Authorization/policySetDefinitions"
    }

    It "<Name> refers to custom policies by prefix" -TestCases $testCases {
        $template = Get-Content -Path $FullName | ConvertFrom-Json

        $managementGroupIds = $template.properties.policyDefinitions.policyDefinitionId | Select-String -Pattern "^/providers/Microsoft.Management/managementGroups/(.+)/providers/Microsoft.Authorization/policyDefinitions/.+$"

        if ($managementGroupIds.Matches) {
            $managementGroupIds.Matches | ForEach-Object {
                $PSItem.Groups[1].Value | Should -Be "<prefix>"
            }
        }
    }
}
