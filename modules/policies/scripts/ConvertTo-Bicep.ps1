<#
.DESCRIPTION
Script to convert ALZ-Bicep policies to bicep format

.EXAMPLE
Get-ChildItem -Path "$pathToAlzBicep/infra-as-code\bicep\modules\policy\definitions\lib\policy_set_definitions" -Filter *.json |
Where-Object Name -NotMatch "\.parameters\.json" |
ForEach-Object {
    Write-Output $PSItem -ForegroundColor Green
    .\ConvertTo-Bicep.ps1 -DefinitionFilePath $PSItem -OutputPath "$PSScriptRoot/initiatives"
}
#>
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "", Justification = "False positive")]
param (
    [String[]]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    $DefinitionFilePath,

    [String]
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    $OutputPath
)

begin {}

process {
    $DefinitionFilePath | ForEach-Object {
        $template = Get-Content -Path "$PSScriptRoot/template.json" -Raw
        $inputFile = Get-Item -Path $PSItem
        $outputFile = Join-Path -Path $OutputPath -ChildPath $inputFile.Name
        $definition = $inputFile | Get-Content -Raw

        $definition = $definition -replace "`"scope`": null,", ""
        $definition = $definition -replace "`"\[", "`"[["

        if ($definition -match "`"identity`": \{\s+`"type`": `"SystemAssigned`"\s+\}") {
            $template = $template -replace "`"parameters`": \{\}", "`"parameters`": {`"location`":{`"type`":`"string`",`"defaultValue`":`"[deployment().location]`"}}"
            $definition = $definition -replace "`"location`": null,", "`"location`": `"[parameters('location')]`","
        }
        else {
            $definition = $definition -replace "`"location`": null,", ""
        }

        $definition = $definition -replace
            "`"policyDefinitionId`": `"/providers/Microsoft.Authorization/(.+)/(.+)`"",
            "`"policyDefinitionId`": `"[tenantResourceId('Microsoft.Authorization/`${1}', '`${2}')]`""
        $definition = $definition -replace
            "`"policyDefinitionId`": `"\$\{.+\}/providers/Microsoft.Authorization/(.+)/(.+)`"",
            "`"policyDefinitionId`": `"[extensionResourceId(managementGroup().id, 'Microsoft.Authorization/`${1}', '`${2}')]`""
        $definition = $template -replace "`"resources`": \[\]", "`"resources`": [$definition]"
        $definition | Set-Content $outputFile

        & az bicep decompile --file $outputFile --force

        Remove-Item -Path $outputFile
    }
}

end {}
