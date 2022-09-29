Describe "Test-Definition" {
    $path = Resolve-Path "$PSScriptRoot/../definitions"

    $testCases = Get-ChildItem -Path $path -Include *.bicep -Recurse | ForEach-Object {
        @{
            Name     = $PSItem.FullName.Replace($path, "")
            FullName = $PSItem.FullName
            BaseName = $PSItem.BaseName
        }
    }

    It "<Name> has same name as file" -TestCases $testCases {
        $content = Get-Content -Path $FullName -Raw

        $name = $content | Select-String -Pattern "resource .+ 'Microsoft.Authorization/policyDefinitions@\d{4}-\d{2}-\d{2}'\s+=\s+{\s+.+\s+name: '(.+)'\s+"

        $name.Matches.Success | Should -Be $true

        $name.Matches[0].Groups[1].Value | Should -Be $BaseName
    }
}
