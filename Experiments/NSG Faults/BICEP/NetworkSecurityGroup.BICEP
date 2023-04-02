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

// RDC adding 3/20 to test 
// Target/Capability Resources 
  // First NSG is used for testing the SecurityRule-1.0 fault. 
  // Second NSG is used for testing the sad path of Target resource validation. 
  // Third NSG is used for testing the sad path of Capability resource validation. 
  resource networkSecurityGroupTarget 'Microsoft.Chaos/targets@2021-09-15-preview' =  { 
    name: 'Microsoft-NetworkSecurityGroup' 
    scope: networkSecurityGroups_resource 
    properties: {} 
  } 
  
  resource securityRuleCapability 'Microsoft.Chaos/targets/capabilities@2021-09-15-preview' = { 
    name: '${networkSecurityGroupTarget.name}/SecurityRule-1.0' 
    scope: networkSecurityGroups_resource 
  } 
  output name string = networkSecurityGroups_resource.name
// End of 3/20 test


// output NsgId string = networkSecurityGroups_resource.id
// part of the working code 
