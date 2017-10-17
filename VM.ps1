#= French version - objectifs :
#= VM Windows à partir d'un modele ARM
#-- Work with Azure Cloud Shell (PowerShell)

#-- Creer un resource Group pour deployer la VM
New-AzureRmResourceGroup -Name RG-TEST -Location "West US 2"

#-- Tester avant de deployer ---
Test-AzureRmResourceGroupDeployment -ResourceGroupName RG-Test -TemplateFile .\azuredeployVMPassVault.json -TemplateParameterFile .\azuredeployVMPassVault.parameters.json

#-- Deployer la VM avec mot de passe stocke dans Azure Key Vault a partir d'un modele ARM et d'un fichier de parametre contenant le chemin vers le secret dans le Vault
New-AzureRmResourceGroupDeployment -ResourceGroupName RG-Test -TemplateFile .\azuredeployVMPassVault.json -TemplateParameterFile .\azuredeployVMPassVault.parameters.json


##-- FlushAll
# Remove-AzureRmResourceGroup -name "RG-TEST"
