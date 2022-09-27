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

pop-location

####################################################
## Script to sync Management Group Bicep from ALZ Bicep repo ##
#  __  __                                                   _    _____           
#  |  \/  |                                                 | |  / ____|          
#  | \  / | __ _ _ __   __ _  __ _  ___ _ __ ___   ___ _ __ | |_| |  __ _ __ ___   _   _ _ __  ___ 
#  | |\/| |/ _` | '_ \ / _` |/ _` |/ _ \ '_ ` _ \ / _ \ '_ \| __| | |_ | '__/ _ \ | | | | '_ \/ __|
#  | |  | | (_| | | | | (_| | (_| |  __/ | | | | |  __/ | | | |_| |__| | | | (_) || |_| | |_) \__ \
#  |_|  |_|\__,_|_| |_|\__,_|\__, |\___|_| |_| |_|\___|_| |_|\__|\_____|_|  \___/  \__,_| .__/|___/
#                             __/ |                                                     | |
#                            |___/                                                      |_| 
#
####################################################


Push-Location 
Set-Location .\DenmarkPubSecALZ\src\resources\infra-as-code\bicep\modules\managementGroups

# https://github.com/Azure/ALZ-Bicep/tree/main/infra-as-code/bicep/modules/managementGroups
$response = curl https://api.github.com/repos/Azure/ALZ-Bicep/contents/infra-as-code/bicep/modules/managementGroups
$bicepArtifacts = $response | ConvertFrom-Json

foreach($artifact in $bicepArtifacts){
    write-host " "
    write-host " ##### "
    if($artifact.type -eq 'dir'){
        write-host "artificat type is a dir"
        # create the directory if it doesn't exist
        if(!(Test-Path -Path $artifact.name)){New-Item $artifact.name -ItemType Directory}
        $dirResponse = curl $artifact.url
        $dirArtifacts = $dirResponse | ConvertFrom-Json
        foreach($dArtifact in $dirArtifacts)
        {
            write-host $dArtifact.name
            write-host $dArtifact.download_url
            #Download file    
            Invoke-WebRequest $dArtifact.download_url -OutFile ".\$($artifact.name)\$($dArtifact.name)"
            write-host " ##### "
            write-host " "
        }
    }
    else{
        write-host  
        write-host $artifact.download_url
        #Download file    
        Invoke-WebRequest $artifact.download_url -OutFile $artifact.name
        write-host " ##### "
        write-host " "
    }   
}
