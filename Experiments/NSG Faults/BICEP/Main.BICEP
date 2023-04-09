// Working 3/19/2023
// Created By: Rick Caudle

// This deployment main.Bicep file is intented to be used to deploy NSG type fault experiments
// You can provide a prefix for the Experiment Name and Network Security Group 
// the deployment script will generate a uniquename with the prefix attached to the Experiment name as well as the NSG Name
// You can also specifiy the Destination Address i.e. from a list of:  
/*      'CognitiveServicesFrontend'
        'CognitiveServicesManagement'
        'EventHub'
        'ServiceBus'
        'EventHub'
        '*''CognitiveServicesFrontend'
        'CognitiveServicesManagement'
        'EventHub'
        'ServiceBus'
        'EventHub'
        '*'
  */
// az group create --location eastus --resource-group rg-MyTestGroup
// az deployment group create --resource-group rg-MyTestGrpup --template-file main.bicep 
// -or-
// az deployment group create --resource-group re-MyTestGrpup --template-file main.bicep -p '{"experimentPrefix": {"value":"exp"},"destinationServiceAddress": {"value":"ServiceBus"},"networkSecurityGroupPrefix": {"value":"nsg"}}'
// if you don't pass parameters it will use the details of exp, nsg and ServiceBus


// Setup the Parameters for this Main.BICEP file
// The purpose is to provide a reusable template that can be used for various experiments
@description('Provide the name of the Experiment, the default is exp')
param experimentPrefix string = 'exp1-'

@description('Provide the name of the Network Security Gorup, the default is nsg')
param networkSecurityGroupPrefix string = 'nsg1-'

@description('Provide the Destination Address you would like to target: i.e. CogntiveServicesFrontend, CongitiveSErvicesManagement, ServiceBus...')
@allowed([
  'CognitiveServicesFrontend'
  'CognitiveServicesManagement'
  'EventHub'
  'ServiceBus'
  'EventHub'
  '*'
])
param destinationServiceAddress string = 'ServiceBus'
param location string = resourceGroup().location

var uniqueExperimentName = '${experimentPrefix}${uniqueString(resourceGroup().id)}'
var uniqueNetworkSecurityGroupName = '${networkSecurityGroupPrefix }${uniqueString(resourceGroup().id)}'

module nsgModule 'NetworkSecurityGroup.BICEP' = {
  name: uniqueNetworkSecurityGroupName
  params: {
    networkSecurityGroupName : uniqueNetworkSecurityGroupName
    location: location
  }
}

module expModule 'Experiment.BICEP' = {
   name: uniqueExperimentName
   params: {
    networkSecurityGroupName: uniqueNetworkSecurityGroupName
    serviceDestinationAddresses: destinationServiceAddress
    experimaneName : uniqueExperimentName 
    location: location
  }
}



