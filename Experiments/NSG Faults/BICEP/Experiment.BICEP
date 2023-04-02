// Working 3/19/2023
// Created By: Rick Caudle
param experimaneName string
param location string = resourceGroup().location
param networkSecurityGroupName string

@allowed([
  'CognitiveServicesFrontend'
  'CognitiveServicesManagement'
  'EventHub'
  'ServiceBus'
  'EventHub'
  '*'
])
param serviceDestinationAddresses string

resource experiments_resource 'Microsoft.Chaos/experiments@2022-10-01-preview' = {
  name: experimaneName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    selectors: [
      {
        type: 'List'
        id: '735c806d-19d7-4712-b9ed-021d30347652'
        targets: [
          {
            id: '${resourceGroup().id}/providers/Microsoft.Network/networkSecurityGroups/${networkSecurityGroupName}/providers/Microsoft.Chaos/targets/microsoft-networksecuritygroup'
            type: 'ChaosTarget'
          }
        ]
      }
    ]
    steps: [
      {
        name: 'Step 1'
        branches: [
          {
            name: 'Branch 1'
            actions: [
              {
                type: 'continuous'
                selectorId: '735c806d-19d7-4712-b9ed-021d30347652'
                duration: 'PT10M'
                parameters: [
                  {
                    key: 'sourceAddresses'
                    value: 'Any'
                  }
                  {
                    key: 'sourcePortRanges'
                    value: '["0-65535"]'
                  }
                  {
                    key: 'destinationAddresses'
                    value: '["${serviceDestinationAddresses}"]'
                  }
                  {
                    key: 'destinationPortRanges'
                    value: 'Any'
                  }
                  {
                    key: 'direction'
                    value: 'Outbound'
                  }
                  {
                    key: 'protocol'
                    value: 'Any'
                  }
                  {
                    key: 'action'
                    value: 'Deny'
                  }
                  {
                    key: 'priority'
                    value: '4000'
                  }
                  {
                    key: 'name'
                    value: 'DenyAllOutBound'
                  }
                  {
                    key: 'flushConnection'
                    value: 'true'
                  }
                ]
                name: 'urn:csci:microsoft:networkSecurityGroup:securityRule/1.1'
              }
            ]
          }
        ]
      }
    ]
  }
}

module perms 'NetworkContrib-Perms.bicep' = {
  name: 'servicebus-perms'
  params: {
    principalId: experiments_resource.identity.principalId
    
  }
}

output experimentName string = experiments_resource.name
