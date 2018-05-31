#Login-AzureRmAccount

#Get-AzureRmResourceGroup

$vault="BKP-VAULT-BR"
$rg="Azr-br"
$loc="brazilsouth"

#Cria um vault de backup:
New-AzureRmRecoveryServicesVault -name $vault -ResourceGroupName `$rg -Location $loc 

#Pega as configurações do vault criado e atribui a vault1
$vault1=Get-AzureRmRecoveryServicesVault -Name $vault
#Seleciona o LRS para o backup vaultSet-AzureRmRecoveryServicesBackupProperties -Vault $vault1 `-BackupStorageRedundancy LocallyRedundant 

#Cria uma pasta e baixa as credenciais do vault criado anteriormente
cd c:\
$dir1="c:\azure_creds"
New-Item -ItemType Directory -Path $dir1 -Force
Get-AzureRmRecoveryServicesVaultSettingsFile -backup -vault $vault1 -path $dir