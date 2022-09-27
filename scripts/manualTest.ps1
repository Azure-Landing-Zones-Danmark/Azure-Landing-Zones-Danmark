####################################################
## Script to create Management Group from ALZ Bicep ##
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


az login

Push-Location
Set-Location .\src\resources\infra-as-code\bicep\modules\managementGroups

az deployment tenant create `
--template-file  managementGroups.bicep `
--parameters .\parameters\managementGroups.parameters.all.json `
--location 'westEurope'