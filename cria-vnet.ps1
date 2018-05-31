#Cria um resource group:
New-AzureRmResourceGroup -ResourceGroupName "AZR-BR" -Location "brazil South"

#Variaveis de subnet:
$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -name "FrontEndAZR" -AddressPrefix 192.168.5.0/26
$subnet2 = New-AzureRmVirtualNetworkSubnetConfig -name "BackEndAZR" -AddressPrefix 192.168.5.64/26
$subnet3 = New-AzureRmVirtualNetworkSubnetConfig -name "DMZAZR" -AddressPrefix 192.168.5.128/28
$subnet4 = New-AzureRmVirtualNetworkSubnetConfig -name "GatewayAZR" -AddressPrefix 192.168.5.144/28

#Cria a VNET e atribui as subnets declaradas nas variáveis acima:
$vnetAZR = New-AzureRmVirtualNetwork -name "VNET-AZR-BR" -ResourceGroupName "AZR-BR" `
 -Location "brazilsouth" -AddressPrefix 10.2.0.0/16 -Subnet $subnet1,$subnet2,$subnet3,$subnet4


 
