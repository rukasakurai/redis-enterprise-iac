# Azure Redis Enterprise IaC
## Deploy what is defined in the Bicep file using the Azure CLI
```
az deployment sub create --location japaneast --template-file ./main.bicep
```

### Measuring how long the deployment takes
You could potentially do something like the following.
```bash
start_time=$(date)
SECONDS=0

az deployment sub create --location japaneast --template-file ./main.bicep

duration=$SECONDS

echo "Start time: $start_time"
echo "End time: $(date)"
echo "The deployment took $(($duration / 60)) minutes and $(($duration % 60)) seconds."
```

## Deploy pre-complied ARM template with button
[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Frukasakurai%2Fredis-enterprise-iac%2Fmain%2Fmain.json)
