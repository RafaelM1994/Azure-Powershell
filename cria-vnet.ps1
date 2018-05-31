#Cria um resource group:
New-AzureRmResourceGroup -ResourceGroupName "AZR-BR" -Location "brazil South"

#Variaveis de subnet:
$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -name "FrontEndAZR1" -AddressPrefix 10.2.0.0/25

$subnet2 = New-AzureRmVirtualNetworkSubnetConfig -name "BackEndAZR2" -AddressPrefix 10.2.1.0/25

#Cria a VNET e atribui as subnets declaradas nas variáveis acima:
$vnetAZR = New-AzureRmVirtualNetwork -name "VNET-AZR-BR" -ResourceGroupName "AZR-BR" ` -Location "brazilsouth" -AddressPrefix 10.2.0.0/16 -Subnet $subnet1,$subnet2 