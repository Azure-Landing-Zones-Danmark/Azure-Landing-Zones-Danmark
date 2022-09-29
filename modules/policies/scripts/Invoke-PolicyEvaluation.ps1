# Set subscription before running script
# $ az account set --subscription <guid>

$subscriptionId = (az account show --query id --output tsv)

$uri = "https://management.azure.com/subscriptions/$subscriptionId/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation?api-version=2019-10-01"

& az rest --method post --uri $uri --body '{}'
