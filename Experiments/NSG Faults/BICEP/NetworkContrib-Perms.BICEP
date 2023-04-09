// Working 3/19/2023
// Created By: Rick Caudle
param principalId string

var networkContributorRoleId = '4d97b98b-1d4f-4787-a291-c67834d212e7'

resource networkContributorRole 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  name: networkContributorRoleId
}

resource networkContributorAssignments 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: guid(resourceGroup().name, networkContributorRoleId, principalId)
  properties: {
    principalId: principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: networkContributorRole.id
  }
  scope: resourceGroup()
}
