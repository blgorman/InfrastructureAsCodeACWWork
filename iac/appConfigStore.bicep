param location string = resourceGroup().location
param appConfigStoreName string = 'simpleappconfig234523'
param vaultName string
param identityDBSettingName string = 'IDENTITY_CONFIG_SETTING_NAME'
param 
resource vault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: vaultName
}

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2023-03-01' = {
  name: appConfigStoreName
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

resource symbolicname 'Microsoft.AppConfiguration/configurationStores/keyValues@2023-03-01' = {
  name: 'string'
  parent: resourceSymbolicName
  properties: {
    contentType: 'string'
    tags: {}
    value: 'string'
  }
}
