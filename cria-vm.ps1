﻿Connect-AzureRmAccount

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
$pip= New-AzureRmPublicIpAddress -ResourceGroupName $rg -Location $loc `