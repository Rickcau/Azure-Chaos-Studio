# Azure Chaos Studio - Network Security Group Experiment
Deploying the Main.bicep file will result in the creation of an Azure Chaos Studio Experiment that makes use of an NSG fault.  The purpose of this example is to provide you with a reusable set of Bicep files that can be modified and used to deploy any type of Azure Chaos Experiment and Fault.  <br>

## Description of the files ##

| Filename       | Description |
| ----           | ----        |
| Main.bicep     | This is the primary Bicep file and it has a dependency on the other Bicep files |
|  NetworkSecurityGroup.bicep | Bicep Module that describes the   |
|  Experiment.bicep | Bicep Module that describes the Experiment and the Permissions needed for the Experiment, it has a dependecy on NetworkContrib-Perms.bicep. |
|  NetworkContrib-Perms.bicep | Bicep Module that describes that Network Contributor permissions needed for the Experiment. |    	

## Main.Bicep
This Main.Bicep can accept 4 parameters (optional) that can be passed to the **AZ Deployment Group Create** command.  

**Parameters**
| Parameter   | Description |
| ----------- | ----------- |
| experimentPrefix | Default = 'exp1-' This parameter allows you to set a Prefix for the experiment that is being deployed. |
| networkSecurityGroupPrefix | Default = 'nsg1-' This parameter allows you to set a Prefix for the NSG that is being deployed. |
| destinationServiceAddress" | Default = 'ServiceBus' This parameter allows you to set the NSG service to target.  The allowed values are 'CognitiveServicesFrontend', 'CognitiveServicesManagement', 'EventHub', 'ServiceBus', 'EventHub' or '*'  |
| location    | Default = Location of the Resource Group This parameter allows you to set the location for the deployment. |

## NetworkSecurityGroup.Bicep
The NetworkSecurityGroup.Bicep takes 2 parameters that are passed in from the Main.Bicep file.  The purpose of this Bicep is to setup the NSG, define it as a Chaos Studio Target and to define the Capibilities for the NSG.  

| Parameter   | Description |
| ----------- | ----------- |
| location    | This parameter is set to the resourceGroup().id which is the location of the Resource Group this is being deployed to. |
| networkSecurityGroupName | This parameter is passed in from the Main.Bicep file and it's a combination of a Prefix that was passed to the Main.Bicep file as well as a unique string. |

## Experiment.Bicep
The Experiment.Bicep takes 4 parameters that are passed in from the Main.Bicep file.  The purpose of this Bicep is to setup the Experiment as well as the permissions for the Experiment.

| Parameter   | Description |
| ----------- | ----------- |
| experimaneName |  This value is passed via the Main.Bicep and is a combination of Prefix and a unique string. |
| location       | This parameter is set to the resourceGroup().id which is the location of the Resource Group this is being deployed to. |
| networkSecurityGroupName | This value is passed via the Main.Bicep and is a combination of Prefix and a unique string.  |
| serviceDestinationAddresses | This value is passed via the Main.Bicep. |

## Deploying the Experiment
In order to deploy the **Experiment** a resouce group needs to created or you will need to use an existing Resource Group.  Once the Resource group is created, you can deploy using **az deployment group create**.<br>

1. **az group create --location eastus --resource-group rg-MyTestGroup**
2. **az deployment group create --resource-group rg-MyTestGrpup --template-file main.bicep** 
   If you would like to pass parameters to the main.bicep file you create a parameters.bicep file or pass them in as JSON.  For more details on how to pass parameters, take a look at the online docs for *az deployment group*.
