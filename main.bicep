targetScope = 'subscription'

param resourceGroupName string = ''
param resourceGroupLocation string

param redisEnterpriseName string = ''
param redisEnterpriseLocation string = 'South Central US'

// Organize resources in a resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

resource redisEnterpriseResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = if (!empty(resourceGroupName)) {
  name: resourceGroupName
}

module redisEnterprise 'core/redis/enterprise.bicep' = {
  scope: redisEnterpriseResourceGroup
  name: 'redis-enterprise'
  params: {
    name: redisEnterpriseName
    location: redisEnterpriseLocation
  }
}

output AZURE_TENANT_ID string = tenant().tenantId
output AZURE_RESOURCE_GROUP string = resourceGroup.name
output AZURE_REDIS_ENTERPRISE_RESOURCE_GROUP string = redisEnterpriseResourceGroup.name
