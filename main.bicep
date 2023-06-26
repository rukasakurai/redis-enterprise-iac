targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string

param redisEnterpriseName string
param redisEnterpriseLocation string = 'South Central US'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

module redisEnterprise 'core/redis/enterprise.bicep' = {
  scope: resourceGroup
  name: 'redis-enterprise'
  params: {
    name: redisEnterpriseName
    location: redisEnterpriseLocation
  }
}

output AZURE_TENANT_ID string = tenant().tenantId
output AZURE_RESOURCE_GROUP string = resourceGroup.name
