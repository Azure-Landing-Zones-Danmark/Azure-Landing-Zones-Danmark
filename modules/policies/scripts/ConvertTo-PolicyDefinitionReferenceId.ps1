function ConvertTo-PolicyDefinitionReferenceId {
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [String]
        $DisplayName
    )
    begin {}
    process {
        [System.Globalization.CultureInfo]::InvariantCulture.TextInfo.ToTitleCase($DisplayName.ToLower()) -replace "\W+", ""
    }
    end {}
}

Set-Alias -Name "polref" -Value "ConvertTo-PolicyDefinitionReferenceId"