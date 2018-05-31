Login-AzureRmAccount

#Get-AzureRmResourceGroup

$rg = 'AZR-BR' 
$loc = 'Brazil South'
$nsgname = 'NOVANSG'
$vnet = "VNET-AZR-BR"

#Especificação das regras
$nsgrule1= New-AzureRmNetworkSecurityRuleConfig -name "web" -Direction Inbound `-Priority 100 -Access Allow -SourceAddressPrefix "INTERNET" -SourcePortRange `"*" -DestinationAddressPrefix "*" -DestinationPortRange "443" -Protocol TCP#Criação da NSG com as regrasNew-AzureRmNetworkSecurityGroup -Name $nsgname -Location $loc -ResourceGroupName `$rg -SecurityRules $nsgrule1#ARMAZENAR AS CONFIGURAÇÕES DA NSG na variável

$nsgconfig = Get-AzureRmNetworkSecurityGroup -Name $nsgname -ResourceGroupName $rg

#ARMAZENAR AS CONFIGURAÇÕES DA VNET-AZR-BR

$vnetconfig=Get-AzureRmVirtualNetwork -Name $vnet -ResourceGroupName $rg

#ARMAZENAR O NOME DA SUBNET
$subnetconfig = $vnetconfig.Subnets.Name

#ARMAZENAR O PREFIXO DE REDE DA SUBNET (EX.: 10.0.0.0/24)

$vnetconfig.Subnets.AddressPrefix

#DEFINIR AS CONFIGURAÇÕES DA SUBNET
Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $vnetconfig ` -Name $subnetconfig -AddressPrefix $vnetconfig.Subnets.AddressPrefix ` -NetworkSecurityGroup $nsgconfig 

#SALVAR AS CONFIGURAÇÕES DA VNET
Set-AzureRmVirtualNetwork -VirtualNetwork $vnetconfig

#VISUALIZAÇÃO-AMIGAVEL

(Get-AzureRmNetworkSecurityGroup -Name $nsgname `
 -ResourceGroupName $rg).SecurityRules | Select-Object * | Out-GridView
(Get-AzureRmNetworkSecurityGroup -Name $nsgname ` -ResourceGroupName $rg).DefaultSecurityRules | Select-Object * | Out-GridView