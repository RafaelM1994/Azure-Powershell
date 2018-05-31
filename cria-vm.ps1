Connect-AzureRmAccount

#Variaveis
$rg= "AZR-BR"
$vnet = "VNET-AZR-BR"
$subnet1="BackEndAZR2"
$loc = "brazilsouth"
$pub= "MicrosoftWindowsServer"
$offer="WindowsServer"
$sku = "2016-Datacenter"
$vmsize = "Standard_B2s"


###############COMANDOS DE PESQUISA PARA ARMAZENAR NAS VARIÁVEIS#############
#[1] Recupera todas as imagens de vm publicadas na região escolhida
#Get-AzureRmVMImagePublisher -location 'Brazil South' | select PublisherName

#[2] Recupera todas as imagens de vm publicadas pelo publisher escolhido
#Get-AzureRmVMImageOffer -location $loc -publisher $pub  | select Offer

#[3] Recupera todas as skus da imagem
#Get-AzureRmVMImageSku -Location $loc -Publisher $pub -Offer $offer

#[4] Recupera todos os tamanhos de vm para o local escolhido
#get-azurermvmsize -Location $loc

#[5] Recupera uma lista de Vnets do resource group
#Get-AzureRmVirtualNetwork  -ResourceGroupName $rg

#[6] Recupera uma lista das subnets dentro da vnet
#Get-AzureRmVirtualNetwork -name $vnet -ResourceGroupName $rg 
##############################################################################



##########################CRIAÇÃO DO IP PÚBLICO#############################
$ipname= "IP-PUB-WS16-DC-BR"
$pip= New-AzureRmPublicIpAddress -ResourceGroupName $rg -Location $loc `-AllocationMethod Static -IdleTimeoutInMinutes 4 -name $ipname###############################################################################################CRIAÇÃO DE UMA REGRA DE NSG PARA PERMITIR CONEXÃO RDP#########$NSGRuleRDP = New-AzureRmNetworkSecurityRuleConfig -name Allow_RDP -Protocol Tcp `-Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * `-DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow##############################################################################################CRIAÇÃO DE UMA REGRA DE NSG PARA PERMITIR CONEXÃO WEB#########$NSGRuleWEB = New-AzureRmNetworkSecurityRuleConfig -name Allow_WEB -Protocol Tcp `-Direction Inbound -Priority 1001 -SourceAddressPrefix * -SourcePortRange * `-DestinationAddressPrefix * -DestinationPortRange 80 -Access Allow#####################################################################################################CRIAÇÃO DE UM NSG#####################################$nsgname ="NSG-WS16-DC-BR"$nsg = New-AzureRmNetworkSecurityGroup -name $nsgname -ResourceGroupName $rg `-location $loc -SecurityRules $NSGRuleRDP,$NSGRuleWEB#####################################################################################################CRIAÇÃO DE UMA PLACA DE REDE#################################$nicname="NIC-WS16-DC-EUA"$vnetinfo = Get-AzureRmVirtualNetwork -name $vnet -ResourceGroupName $rg `| Get-AzureRmVirtualNetworkSubnetConfig -name $subnet1$nic= New-AzureRmNetworkInterface -name $nicname -ResourceGroupName $rg `-Location $loc -SubnetId $vnetinfo.id -PublicIpAddressId $pip.Id `-NetworkSecurityGroupId $nsg.Id#####################################################################################################CRIAÇÃO DE UM USUÁRIO#################################$usr="rmedeiros"$pwd= ConvertTo-SecureString -String ".,fakehacker552" -AsPlainText -Force$credinfo = New-Object -TypeName System.Management.Automation.PSCredential ` -ArgumentList $usr, $pwd#####################################################################################################CRIAÇÃO DA VM#################################$vmname="WS16-DC-BR"$vmconfig = New-AzureRmVMConfig -VMName $vmname -VMSize $vmsize | `Set-AzureRmVMOperatingSystem -Windows -ComputerName $vmname -Credential $credinfo `| Set-AzureRmVMSourceImage -PublisherName $pub -Offer $offer -Skus $sku `-Version latest | Add-AzureRmVMNetworkInterface -id $nic.IdNew-AzureRmVM -ResourceGroupName $rg -Location $loc -vm $vmconfig#############################################################################