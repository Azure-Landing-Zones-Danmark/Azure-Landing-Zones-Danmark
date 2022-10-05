Describe "Test-Initiative" {
    $path = Resolve-Path "$PSScriptRoot/../initiatives"

    $testCases = Get-ChildItem -Path $path -Include *.bicep -Recurse | ForEach-Object {
        @{
            Name     = $PSItem.FullName.Replace($path, "")
            FullName = $PSItem.FullName
            BaseName = $PSItem.BaseName -replace "policy_set_definition_es_"
        }
    }

    It "<Name> is similar to file" -TestCases $testCases {
        $content = Get-Content -Path $FullName -Raw

        $name = $content | Select-String -Pattern "resource (.+) 'Microsoft.Authorization/policySetDefinitions@\d{4}-\d{2}-\d{2}'\s+=\s+{\s+.+\s+name: '(.+)'\s+"

        $name.Matches.Success | Should -Be $true

        $name.Matches[0].Groups[1].Value | Should -Be $BaseName
        $name.Matches[0].Groups[2].Value | Should -Be ($BaseName -replace "_", "-")
    }
}
