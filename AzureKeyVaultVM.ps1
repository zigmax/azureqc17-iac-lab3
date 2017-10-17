#Source : https://github.com/squasta/AzureKeyVault-VM-Password/blob/master/CreateAzureKeyVaultandSecretandDeployVM.ps1

#= French version - objectifs :
#= objectif de ce script : creer un Azure key Vault et un secret dans ce Vault
#= definir dans ce vault un secret, ici un mot de passe qui sera utilise pour deployer une 
#= VM Windows à partir d'un modele ARM
#-- Work with Azure Cloud Shell (PowerShell)

#--- Creer un Resource Group pour l Azure Key Vault 
New-AzureRmResourceGroup --Name 'RG-AzureKeyVaultMaxime' -Location 'West Europe'

#-- Creer un Azure key Vault 
New-AzureRmKeyVault -VaultName 'AzureKeyVaultMaxime' -ResourceGroupName 'RG-AzureKeyVaultMaxime' -Location 'West Europe' -EnabledForDeployment -EnabledForDiskEncryption -EnabledForTemplateDeployment


#--- Creer un secret et le stocker dans l'Azure Key Vault ----
$Secret = ConvertTo-SecureString -String 'PasswordDemoAzureQC!' -AsPlainText -Force 
Set-AzureKeyVaultSecret -VaultName 'AzureKeyVaultMaxime' -Name 'PasswordVM' -SecretValue $Secret

#-- Creer un resource Group pour deployer la VM
New-AzureRmResourceGroup -Name RG-TEST -Location "West Europe"

#-- Tester avant de deployer ---
Test-AzureRmResourceGroupDeployment -ResourceGroupName RG-Test -TemplateFile .\azuredeployVMPassVault.json -TemplateParameterFile .\azuredeployVMPassVault.parameters.json

#-- Deployer la VM avec mot de passe stocke dans Azure Key Vault a partir d'un modele ARM et d'un fichier de parametre contenant le chemin vers le secret dans le Vault
New-AzureRmResourceGroupDeployment -ResourceGroupName RG-Test -TemplateFile .\azuredeployVMPassVault.json -TemplateParameterFile .\azuredeployVMPassVault.parameters.json


##-- FlushAll
# Remove-AzureRmResourceGroup -name "RG-AzureKeyVaultMaxime"
# Remove-AzureRmResourceGroup -name "RG-TEST"
