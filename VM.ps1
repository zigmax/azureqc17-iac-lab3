#= French version - objectifs :
#= VM Windows a partir d'un modele ARM
#= Fonctionne avec Azure Cloud Shell (PowerShell)

Login-AzureRMAccount

#-- Creer un resource Group pour deployer la VM
New-AzureRmResourceGroup -Name RG-TEST -Location "West US 2"

#-- Tester avant de deployer
Test-AzureRmResourceGroupDeployment -ResourceGroupName RG-Test -TemplateFile .\azuredeploy.json -TemplateParameterFile .\azuredeploy.parameters.json

#-- Deployer la VM 
New-AzureRmResourceGroupDeployment -ResourceGroupName RG-Test -TemplateFile .\azuredeploy.json -TemplateParameterFile .\azuredeploy.parameters.json


##-- FlushAll
# Remove-AzureRmResourceGroup -name "RG-TEST"
