Describe "Test-Assignment" {
    $path = Resolve-Path "$PSScriptRoot/../assignments"

    $testCases = Get-ChildItem -Path $path -Filter *.bicep -Recurse | Where-Object Name -NE ".deploy.bicep" | ForEach-Object {
        @{
            Name     = $PSItem.FullName.Replace($path, "")
            FullName = $PSItem.FullName
            BaseName = $PSItem.BaseName
        }
    }

    It "<Name> is similar to file" -TestCases $testCases {
        $content = Get-Content -Path $FullName -Raw

        $name = $content | Select-String -Pattern "module (.+) '.+/(?:policy|initiative).+assignment\.bicep'\s+=\s+{\s+name: '(.+)'\s+scope: managementGroup\(managementGroupId\)\s+params: \{(?:\s+location: location)?\s+policyAssignmentName: '(.+)'"

        $name.Matches.Success | Should -Be $true

        $name.Matches[0].Groups[1].Value | Should -Be $BaseName
        $name.Matches[0].Groups[2].Value | Should -Be "$($BaseName -replace "_", "-")-Assignment"
        $name.Matches[0].Groups[3].Value | Should -Be ($BaseName -replace "_", "-")
    }
}
