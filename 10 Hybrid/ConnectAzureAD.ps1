$AzureAdCred = Get-Credential
Connect-AzureAD -Credential $AzureAdCred
get-azureadgroup