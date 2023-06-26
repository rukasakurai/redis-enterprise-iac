# Azure Redis Enterprise IaC
## Deploy what is defined in the Bicep file using the Azure CLI
```
az deployment sub create --parameter environmentName=redis-bicep-only --location japaneast --template-file ./main.bicep
```
## Deploy pre-complied ARM template with button
[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Frukasakurai%2Fredis-enterprise-iac%2Fmain%2Fmain.json)
