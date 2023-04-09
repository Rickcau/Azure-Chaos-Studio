// 4/9/2023
// This file is not used with the Main.bicep as I have added the capabilities/targets inline within the NetworkSecurityGroup.bicep file
// This file is here to provide an example of how you can abstract these out into a separate bicep file.
param nsgName string
param location string = resourceGroup().id

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-03-01' existing = {
  name: nsgName
}



resource nsgTarget 'Microsoft.Network/networkSecurityGroups/providers/targets@2021-09-15-preview' = {
  name: '${nsg.name}/Microsoft.Chaos/Microsoft-NetworkSecurityGroup'
  location: location
  properties: {}

  resource setRules1 'capabilities' = {
    name: 'SecurityRule-1.0'
    location: location
  }

  resource setRules2 'capabilities' = {
    name: 'SecurityRule-1.1'
    location: location
  }
}


resource nsgTarget 'Microsoft.Network/networkSecurityGroups/providers/targets@2021-09-15-preview' = { 
    name: '${nsg.name}/Microsoft.Chaos/Microsoft-NetworkSecurityGroup'
    location: location
    type: 'Microsoft.Network/networkSecurityGroups/providers/targets/capabilities'
    properties: {}
   
}

resource setRules 'Microsoft.Chaos/targets/capabilities@2022-10-01-preview' = {
  name: 'SecurityRule-1.0'
  
  parent: nsgTarget
  scope: nsgTarget
}

resource setRules 'Microsoft.Chaos/targets/capabilities@2022-10-01-preview' = {
  name: 'SecurityRule-1.1'
  
  parent: nsgTarget
  scope: nsgTarget
}

