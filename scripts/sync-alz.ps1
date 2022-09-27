####################################################
## Script to sync Custom Policy from ALZ repo ##
#
#   _______     ___   _  _____ 
#   / ____\ \   / / \ | |/ ____|
#  | (___  \ \_/ /|  \| | |     
#   \___ \  \   / | . ` | |     
#  _ ___) |  | |  | |\  | |____ 
#  |_____/   |_|  |_| \_|\_____|
#
#                            
####################################################
# Get Policy Defintions
#https://github.com/Azure/Enterprise-Scale/tree/main/src/resources/Microsoft.Authorization/policyDefinitions

Push-Location 
Set-Location .\DenmarkPubSecALZ\src\resources\Microsoft.Authorization\policyDefinitions
$response = curl https://api.github.com/repos/Azure/Enterprise-Scale/contents/src/resources/Microsoft.Authorization/policyDefinitions

$policyDefintions = $response | ConvertFrom-Json
foreach($policydef in $policyDefintions ){
    write-host " "
    write-host " ##### "
    write-host $policydef.name
    write-host $policydef.download_url
    #Download file    
    Invoke-WebRequest $policydef.download_url -OutFile $policydef.name
    write-host " ##### "
    write-host " "
}

pop-location
Push-Location 
Set-Location .\DenmarkPubSecALZ\src\resources\Microsoft.Authorization\policySetDefinitions

# Get Policy Set Defintions
# https://github.com/Azure/Enterprise-Scale/tree/main/src/resources/Microsoft.Authorization/policySetDefinitions
Push-Location 
Set-Location .\DenmarkPubSecALZ\src\resources\Microsoft.Authorization\policyDefinitions

$response = curl https://api.github.com/repos/Azure/Enterprise-Scale/contents/src/resources/Microsoft.Authorization/policySetDefinitions
$policySetDefintions = $response | ConvertFrom-Json
foreach($policySetDef in $policySetDefintions ){
    write-host " "
    write-host " ##### "
    write-host $policySetDef.name
    write-host $policySetDef.download_url
    #Download file    
    Invoke-WebRequest $policySetDef.download_url -OutFile $policySetDef.name
    write-host " ##### "
    write-host " "
}
