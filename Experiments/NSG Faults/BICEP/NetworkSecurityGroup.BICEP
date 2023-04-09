param location string = resourceGroup().id
param networkSecurityGroupName  string

resource networkSecurityGroups_resource 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: networkSecurityGroupName 
  location: location
  properties: {
    flushConnection: true
      securityRules: [
          {
              name: 'Allow-SSH'
              properties: {
                  priority: 100
                  direction: 'Inbound'
                  access: 'Allow'
                  protocol: 'Tcp'
                  sourceAddressPrefix: '*'
                  sourcePortRange: '*'
                  destinationAddressPrefix: '*'
                  destinationPortRange: '22'
              }
          }
      ]
  }
}

// RDC Update: 3/20/2023 - Added Capabiliies and Targets inline.  These could be moved to a separate Bicep file.  See Nsg-Capsbilities.BICEP for example
// If moved to a separate file, you would need to use a Module to important these capabilities/targers

  resource networkSecurityGroupTarget 'Microsoft.Chaos/targets@2021-09-15-preview' =  { 
    name: 'Microsoft-NetworkSecurityGroup' 
    scope: networkSecurityGroups_resource 
    properties: {} 
  } 
  
  resource securityRuleCapability1 'Microsoft.Chaos/targets/capabilities@2021-09-15-preview' = { 
    name: '${networkSecurityGroupTarget.name}/SecurityRule-1.0' 
    scope: networkSecurityGroups_resource 
  } 

  resource securityRuleCapability2 'Microsoft.Chaos/targets/capabilities@2021-09-15-preview' = { 
    name: '${networkSecurityGroupTarget.name}/SecurityRule-1.1' 
    scope: networkSecurityGroups_resource 
  } 
  
  output name string = networkSecurityGroups_resource.name
// End of 3/20 test


// output NsgId string = networkSecurityGroups_resource.id
// part of the working code 
