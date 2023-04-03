# Useful Azure CLI Commands
The following commands come in handy when useing Azure Chaos Studio

### Check to see if the Microsoft.Chaos provider is registered <br>
   **Bash**

   ~~~
    az provider show --namespace 'Microsoft.Chaos' | grep registrationState
   ~~~
   
### Enumerate properties for the Microsoft.Chaos Provider <br>
   **Bash or PS**

   ~~~
    az provider show --namespace Microsoft.Chaos
   ~~~
    
### Register a Provider <br>
  **Bash or PS**

   ~~~
    az provider register --namespace Microsoft.Chaos
    az provider register --namespace Microsoft.ServiceBus
    az provider register --namespace Microsoft.storage
   ~~~
    
### Determine if a Target is enabled<br>
  **Bash or PS**
  Replace all items in < > with items that are valid for your environment.
   ~~~
    az rest --method get --url "https://management.azure.com/subscriptions/<SUB_ID>/resourceGroups/<RESOURCE_GROUP>/providers/Microsoft.Network/networkSecurityGroups/<NSG_NAME>/providers/Microsoft.Chaos/targets/microsoft-networksecuritygroup?api-version=2021-09-15-preview"
   ~~~
   
   ### Determine if a Capibility is enabled<br>
  **Bash or PS**
  Replace all items in < > with items that are valid for your environment.
   ~~~
    az rest --method get --url "https://management.azure.com/subscriptions/<SUB_ID>/resourceGroups/<RESOURCE_GROUP>/providers/Microsoft.Network/networkSecurityGroups/<NSG_NAME>/providers/Microsoft.Chaos/capabilities/microsoft-networksecuritygroup?api-version=2021-09-15-preview"
   ~~~
  
