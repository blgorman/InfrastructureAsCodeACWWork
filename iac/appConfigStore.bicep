param location string 
param uniqueIdentifier string 
param appConfigStoreName string 
param vaultFullName string
param identityDBConnectionStringKey string
param managerDBConnectionStringKey string 
param identityDbSecretURI string
param managerDbSecretURI string

var configName = '${appConfigStoreName}-{uniqueIdentifier}'

resource vault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: vaultFullName
}

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2023-03-01' = {
  name: configName
  location: location
  sku: {
    name: 'free'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    encryption: {}
    disableLocalAuth: false
    softDeleteRetentionInDays: 0
    enablePurgeProtection: false
  }
}

resource identityDBConnectionKeyValuePair 'Microsoft.AppConfiguration/configurationStores/keyValues@2023-03-01' = {
  name: identityDBConnectionStringKey
  parent: appConfig
  properties: {
    contentType: 'vaultSecretReference'
      value: '@Microsoft.KeyVault(SecretUri=${identityDbSecretURI})'
  }
}

resource managerDBConnectionKeyValuePair 'Microsoft.AppConfiguration/configurationStores/keyValues@2023-03-01' = {
  name: managerDBConnectionStringKey
  parent: appConfig
  properties: {
    contentType: 'vaultSecretReference'
      value: '@Microsoft.KeyVault(SecretUri=${managerDbSecretURI})'
  }
}

output appConfigStoreName string = appConfig.name
