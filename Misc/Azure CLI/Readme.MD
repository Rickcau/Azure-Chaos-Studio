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
    
