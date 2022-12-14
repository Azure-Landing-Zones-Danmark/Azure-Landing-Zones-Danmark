[CmdletBinding(SupportsShouldProcess = $true)]
param (
    [Parameter(Mandatory = $true)]
    [String]$Path,

    [Parameter(Mandatory = $true)]
    [String]$Location,

    [Parameter(Mandatory = $true)]
    [String]$templateFile,

    [Parameter(Mandatory = $true)]
    #[ValidateSet("remove", "keep")]
    [String]$removeUnmanagedExemptions
)

# Get existing Exemptions
$deployedExemptions = (Get-AzPolicyExemption | Select-Object -ExpandProperty Properties).DisplayName

# Get Exemptions to be deployed
$exemptions = Get-ChildItem -Path "$Path/*.json"

#create empty array for
$exemptionNames =@()

# Deploy new exemptions
foreach($exemption in $exemptions){
    $exemptionDisplayName = ($exemption | Get-Content -Raw| ConvertFrom-Json).parameters.displayName.value
    $exemptionName = ($exemption | Get-Content -Raw| ConvertFrom-Json).parameters.exemptionName.value
    $exemptionNames += $exemptionName
    if($deployedExemptions -match $exemptionDisplayName)
        {write-output "Exemption: $exemptionDisplayName is already deployed"}
    else{
            $parameters = @{
            templateFile            = $templateFile
            templateParameterFile   = "$Path\$($exemption.Name)"
            location                = $Location
            }
            #deploy Governance Rule Bicep
            write-output "Exemption: $exemptionDisplayName will be deployed"
            New-AzDeployment @parameters -Verbose
    }
}

#Remove Un-manged Exemptions
If($removeUnmanagedExemptions -eq "remove"){
    $deployedExemptions = Get-AzPolicyExemption | Select-Object -ExpandProperty Name
    foreach($deployedExemption in $deployedExemptions){
        if(-not($deployedExemption -match $exemptionNames)){
            #remove the un-managed exemption
            write-output "Un-managed Exemption: $deployedExemption will be removed"
            Remove-AzPolicyExemption -Name $deployedExemption -Force
        }
    }
}