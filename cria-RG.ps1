Connect-AzureRmAccount

Get-AzureRmSubscription

Get-AzureRmResourceGroup

get-azurermlocation | select location

#Cria um resource group:
New-AzureRmResourceGroup -ResourceGroupName "AZR-BR" -Location "brazil South"

#Recupera uma lista de Vnets do resource group
Get-AzureRmVirtualNetwork  -ResourceGroupName "Azr-BR"

#Remove uma subnet
Remove-AzureRmVirtualNetwork -ResourceGroupName AZR-BR -Name Vnet-azr-br