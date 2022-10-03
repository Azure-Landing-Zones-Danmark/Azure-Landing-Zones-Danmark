Describe "Test-Assignment" {
    $path = Resolve-Path "$PSScriptRoot/../assignments"

    $testCases = Get-ChildItem -Path $path -Include *.bicep -Recurse | ForEach-Object {
        @{
            Name     = $PSItem.FullName.Replace($path, "")
            FullName = $PSItem.FullName
        }
    }

    It "<Name> is assigned to correct management group" -TestCases $testCases {
        $assignment = Get-Item -Path $FullName
        $managementGroup = $assignment.Directory.BaseName
        $content = Get-Content -Path $FullName -Raw

        $param = $content | Select-String -Pattern "param managementGroupId string = '(.+)'"

        $param.Matches.Success | Should -Be $true

        $param.Matches[0].Groups[1].Value | Should -Be $managementGroup

        $scope = $content | Select-String -Pattern "module .+ '.+/(?:policy|initiative).+assignment\.bicep'\s+=\s+{\s+.+\s+scope: managementGroup\(managementGroupId\)\s+"

        $scope.Matches.Success | Should -Be $true
    }
}
