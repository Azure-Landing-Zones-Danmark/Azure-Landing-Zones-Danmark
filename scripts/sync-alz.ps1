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




# Script to Sync Artificats from the Azure Landing Zone BICEP repository which is located at https://github.com/Azure/ALZ-Bicep
# 
# These are the urls the will be synced:
#
# https://github.com/Azure/ALZ-Bicep/tree/main/infra-as-code/bicep/modules/managementGroups
# https://github.com/Azure/ALZ-Bicep/tree/main/infra-as-code/bicep/CRML
# https://github.com/Azure/ALZ-Bicep/tree/main/infra-as-code/bicep/modules/policy
#
# The urls need to be converted to go through the got hub api: https://api.github.com/repos/<ORGNAME>/<REPONAME>/contents/Path-to-Content
#
# The ambition is to convert this script into a Github custom action
#

Function sync-alzBicepRepo{
    param(
        $url,
        $location
    )

    $response = curl $url
    $bicepArtifacts = $response | ConvertFrom-Json
    set-location $location
    foreach($artifact in $bicepArtifacts){
        write-host " "
        write-host " ##### "
        if($artifact.type -eq 'dir'){
            write-host "artificat type is a dir"
            write-host $artifact.name
            write-host $artifact.url
            write-host $location
            Get-location

            # create the directory if it doesn't exist
            if(!(Test-Path -Path $artifact.name)){New-Item $artifact.name -ItemType Directory}            
            
            #jump into the directory
            set-location .\$($artifact.name)
            $newlocation = Get-Location
            write-host $location
            Get-Location

            $dirResponse = curl $artifact.url
            $dirArtifacts = $dirResponse | ConvertFrom-Json        
            foreach($dArtifact in $dirArtifacts)
            {
                if($dArtifact.type -eq 'dir'){
                    write-host "calling function recursively"
                    write-host $dArtifact.name
                    write-host $dArtifact.url
                    write-host $dArtifact
                    write-host $location
                    write-host $newlocation
                    Get-Location
                    sync-alzBicepRepo -url $dArtifact.url -location $newlocation                    
                }
                else{
                    ##write-host $dArtifact.download_url
    
                    #Download file    
                    #Invoke-WebRequest $dArtifact.download_url -OutFile ".\$($artifact.name)\$($dArtifact.name)"
                    #Invoke-WebRequest $dArtifact.download_url -OutFile $dArtifact.name
                }
                set-location 
            }
            
            # jump out of Directory
            set-location $location
        }
        else{
            #write-host $dArtifact.name
            #write-host $dArtifact.download_url
            #Download file    
            #Invoke-WebRequest $artifact.download_url -OutFile $artifact.name
        }
        write-host " ##### "
        write-host " "
    }  
}

Function sync-alzBicepRepo{
    param(
        $url,
        $location
    )

    $response = curl $url
    $bicepArtifacts = $response | ConvertFrom-Json
    set-location $location
    $currentLocation = Get-Location
    write-host "location from function  is: $($location)"    
    write-host "Current Location is $($currentLocation)"
    foreach($artifact in $bicepArtifacts){

        if($artifact.type -eq 'dir'){
            write-host "artificat type is a dir"
            write-host $artifact.name
            write-host $artifact.url
            $currentLocation = Get-location
            write-host "location from function  is: $($location)"    
            write-host "Current Location is $($currentLocation)"

            # create the directory if it doesn't exist
            if(!(Test-Path -Path $artifact.name)){New-Item $artifact.name -ItemType Directory}            
            
            #jump into the directory
            write-host "Changing Directory - jump into $($artifact.name)"
            set-location .\$($artifact.name)
            $newlocation = Get-Location
            $currentLocation = Get-location
            write-host "location from function  is: $($location)"    
            write-host "Current Location is $($currentLocation)"

            $dirResponse = curl $artifact.url
            $dirArtifacts = $dirResponse | ConvertFrom-Json        
            foreach($dArtifact in $dirArtifacts)
            {
                if($dArtifact.type -eq 'dir'){
                    write-host "calling function recursively"
                    write-host $dArtifact.name
                    write-host $dArtifact.url
                    write-host $dArtifact
                    write-host "location from function  is: $($location)"    
                    write-host "Current Location is $($currentLocation)"
                    write-host "New Location is $($newlocation)"
                    Get-Location
                    sync-alzBicepRepo -url $dArtifact.url -location $newlocation                    
                }
                else{
                    ##write-host $dArtifact.download_url
    
                    #Download file    
                    #Invoke-WebRequest $dArtifact.download_url -OutFile ".\$($artifact.name)\$($dArtifact.name)"
                    #Invoke-WebRequest $dArtifact.download_url -OutFile $dArtifact.name
                }
                set-location 
            }
            
            # jump out of Directory
            write-host "Jump out of the Directory and into the original location"
            $currentLocation = Get-location
            write-host "location from function  is: $($location)"    
            write-host "Current Location is $($currentLocation)"
            set-location $location
            $currentLocation = Get-location
            write-host "New Location is $($currentLocation)"
        }
        else{
            #write-host $dArtifact.name
            #write-host $dArtifact.download_url
            #Download file    
            #Invoke-WebRequest $artifact.download_url -OutFile $artifact.name
        }
        write-host " ##### "
        write-host " "
    }  
}




Push-Location 
Set-Location .\DenmarkPubSecALZ\src\Bicep\ALZ-Bicep

# Urls to fetch content from: uncomment to run

Set-Location .\DenmarkPubSecALZ\src\Bicep\ALZ-Bicep\modules\managementGroups
$response = curl https://api.github.com/repos/Azure/ALZ-Bicep/contents/infra-as-code/bicep/modules/managementGroups


Pop-location
Set-Location .\DenmarkPubSecALZ\src\Bicep\ALZ-BICEP\CRML
$response = curl https://api.github.com/repos/Azure/ALZ-Bicep/contents/infra-as-code/bicep/CRML

Pop-Location
Set-Location .\DenmarkPubSecALZ\src\Bicep\ALZ-Bicep\modules\policy
$location = Get-Location
sync-alzBicepRepo -url https://api.github.com/repos/Azure/ALZ-Bicep/contents/infra-as-code/bicep/modules/policy -location $location


$response = curl https://api.github.com/repos/Azure/ALZ-Bicep/contents/infra-as-code/bicep/modules/policy


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
            #Invoke-WebRequest $dArtifact.download_url -OutFile ".\$($artifact.name)\$($dArtifact.name)"
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
pop-location