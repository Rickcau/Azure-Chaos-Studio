// Example BICEP to create a storage account
// also, using the uniqueString(resourceGroup().id) function to create a unique name for the storage account
// it's best practive to do this as a sufix as some resouce names have first letter rescritcitons 
// we are also using output to return the storageAccount.id to the user that executes the template

param location string = resourceGroup().location
param namePrefix string = 'storage'

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}'
var storageAccountSku = 'Standard_RAGRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountId string = storageAccount.id
