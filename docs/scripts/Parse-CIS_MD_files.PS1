# This file will parse the .md files for the NIST and CIS regulatory compliance and produce output that can be pasted into excel
# It can be used to create / update the Security Mapping spreadsheet

# Comment / uncomment the required URI

# NIST SP 800 53 Revision 5
# $uri = "https://raw.githubusercontent.com/MicrosoftDocs/azure-docs/main/articles/governance/policy/samples/nist-sp-800-53-r5.md"
# CIS
$uri = "https://raw.githubusercontent.com/MicrosoftDocs/azure-docs/main/articles/governance/policy/samples/cis-azure-1-3-0.md"

$rawFile = "rawFile.md"
$parsedFile = "parsedFile.md"

Invoke-WebRequest -Uri $uri -OutFile $rawFile

$regexControlFamily = "## "
$regexControlTitle = "###"
$regexID = "**ID**:"
$regexOwnership = "**Ownership**:"
$regexPolicyUri = "(https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F"
$regexPreviewPolicyUri = "Preview"
$columnHeaders = "|Control Family|Control Title|ID|Ownership|Name<br /><sub>(Azure portal)</sub> |Description |Effect(s) |Version<br /><sub>(GitHub)</sub> | Azure Policy Guid |"
$columns = "|---|---|---|---|---|---|---|---|---|"

New-Item $parsedFile -ItemType File -Value $columnHeaders
Add-Content $parsedFile $columns

foreach ($line in Get-Content $rawFile) {
    if ($line -eq "|Name<br /><sub>(Azure portal)</sub> |Description |Effect(s) |Version<br /><sub>(GitHub)</sub> |") { continue }
    if ($line -eq "|---|---|---|---|---|---|---|---|") { continue }

    if ($line.StartsWith($regexControlFamily)) {
        $controlFamily = $line -replace ([regex]::Escape($regexControlFamily)), ''
    }

    if ($line.StartsWith($regexControlTitle)) {
        $controlTitle = $line -replace ([regex]::Escape($regexControlTitle)), ''
    }

    if ($line.StartsWith($regexID )) {
        $ID = $line -replace ([regex]::Escape($regexID )), ''
    }

    if ($line.StartsWith($regexOwnership )) {

        $Ownership = $line -replace ([regex]::Escape($regexOwnership)), ''
    }

    if ($line.StartsWith("|")) {

        if ($line -match $regexPreviewPolicyUri) {
            $policyUri = ((($line.split("|"))[2]).split("]"))[1]
        }
        else {
            $policyUri = ((($line.split("|"))[1]).split("]"))[1]
        }

        $policyGuid = $policyUri -replace ([regex]::Escape($regexPolicyUri)), ''
        $policyGuid = $policyGuid.Trim()

        $newline = "| $controlFamily | $controlTitle | $ID | $Ownership $line $policyGuid |"
        Add-Content $parsedFile $newline
    }
}