# Azure-Chaos-Studio
The intent of this repo is to provide various artifacts that help you better understand Azure Chaos Studio and how you might go about creating and setting up Experiments in an automated manner.  I hope the tips and resources found in this repository help you onboard and deploy your experiments in Chaos Studio much faster. <br>

Click here for an overview of Azure Chaos Studio.

## Network Security Group Experiment
I have created a set of Bicep files that will allow you to quickly deploy an Experiment that leverages an NSG.  It will setup the necessary permissions for the Experiment, enable the Target and Capabilities as well.<br>

In this Experiment I create an **Experiment** that creates a Fault for **Service Bus**.  When you run the experiement you will see the rule enabled and all traffic to **Service Bus** will be denied. 

### Navigate to the NSG Experiment for details ### 

[NSG Experiment](Experiments/NSG%20Faults/BICEP)


