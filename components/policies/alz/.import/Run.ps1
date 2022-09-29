Get-ChildItem -Path "$PSScriptRoot/../infra-as-code\bicep\modules\policy\definitions\lib\policy_definitions" -Filter *.json |
ForEach-Object {
    Write-Host $PSItem -ForegroundColor Green
    .\ConvertTo-Bicep.ps1 -DefinitionFilePath $PSItem -OutputPath "$PSScriptRoot/policy-definitions"
}

Get-ChildItem -Path "$PSScriptRoot/../infra-as-code\bicep\modules\policy\definitions\lib\policy_set_definitions" -Filter *.json |
Where-Object Name -NotMatch "\.parameters\.json" |
ForEach-Object {
    Write-Host $PSItem -ForegroundColor Green
    .\ConvertTo-Bicep.ps1 -DefinitionFilePath $PSItem -OutputPath "$PSScriptRoot/policy-set-definitions"
}