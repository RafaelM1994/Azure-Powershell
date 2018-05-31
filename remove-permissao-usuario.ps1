Connect-AzureRmAccount

$rg=azr-br
$idconta=fe2d0e4e-b5fc-4e0a-bd3b-baa434b10c64Remove-AzureRmRoleAssignment -ObjectId $idconta -RoleDefinitionName "contributor" `-ResourceGroupName $rg