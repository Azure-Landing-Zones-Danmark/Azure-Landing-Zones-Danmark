Describe "Wait-Debugger" {
    $path = Resolve-Path "$PSScriptRoot/.."

    $testCases = Get-ChildItem -Path $path -Include *.ps1, *.psm1 -Exclude "Wait-Debugger.Tests.ps1" -Recurse | ForEach-Object {
        @{
            Name     = $PSItem.FullName.Replace($path, "")
            FullName = $PSItem.FullName
        }
    }

    It "<Name> contains no calls to Wait-Debugger" -TestCases $testCases {
        Get-Content -Path $FullName | Should -Not -Match "Wait-Debugger"
    }
}
