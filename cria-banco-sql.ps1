﻿#Login-AzureRmAccount

#Get-AzureRmResourceGroup
$rg="azr-br"
$loc= "centralus"
$srvname="contoso-sql-srv-azr-br"
$sqlusr="admsql"
$admpwd=ConvertTo-SecureString ".,fakehacker552" -AsPlainText -Force
$dbname="DB01"
$dbname2="DB02"

$cred=New-Object System.Management.Automation.PSCredential -ArgumentList $sqlusr,`
 
 #Cria um novo servidor
 New-AzureRmSqlServer -ResourceGroupName $rg -ServerName $srvname -Location $loc `