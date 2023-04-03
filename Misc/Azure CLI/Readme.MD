# Useful Azure CLI Commands
The following commands come in handy when useing Azure Chaos Studio

## Check to see if the Microsoft.Chaos provider is registered ##
    ~~~
    az provider show --namespace 'Microsoft.Chaos' | grep registrationState
    ~~~
    
    