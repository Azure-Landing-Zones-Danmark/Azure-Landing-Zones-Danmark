param (
    [String[]]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    $DefinitionFilePath,

    [String]
    [ValidateNotNullOrEmpty()]
    $OutputPath = "$PSScriptRoot/policy-definitions"
)

begin {
    $template = Get-Content -Path "$PSScriptRoot/policy-definition-template.json" -Raw
}

process {
    $DefinitionFilePath | ForEach-Object {
        $inputFile = Get-Item -Path $PSItem
        $outputFile = Join-Path -Path $OutputPath -ChildPath $inputFile.Name
        $definition = $inputFile | Get-Content -Raw

        $definition = $definition -replace "`"scope`": null,", ""
        $definition = $definition -replace "`"\[", "`"[["
        $definition = $template -replace "`"resources`": \[\]", "`"resources`": [$definition]"

        $definition | Set-Content $outputFile

        & az bicep decompile --file $outputFile --force

        Remove-Item -Path $outputFile
    }
}

end {}