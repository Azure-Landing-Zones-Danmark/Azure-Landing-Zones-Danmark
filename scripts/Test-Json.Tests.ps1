Describe "Test-Json" {
    $path = Resolve-Path "$PSScriptRoot/.."

    $testCases = Get-ChildItem -Path $path -Include *.json -Recurse | ForEach-Object {
        @{
            Name     = $PSItem.FullName.Replace($path, "")
            FullName = $PSItem.FullName
        }
    }

    It "<Name> is valid json" -TestCases $testCases {
        Test-Json -Json (Get-Content -Path $FullName -Raw) | Should -Be $true
    }
}
