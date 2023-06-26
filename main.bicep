targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

param resourceGroupName string = ''

param redisEnterpriseName string = ''
param redisEnterpriseResourceGroupName string = ''
param redisEnterpriseResourceGroupLocation string = 'South Central US'

var abbrs = loadJsonContent('abbreviations.json')
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))
var tags = { 'azd-env-name': environmentName }

// Organize resources in a resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: !empty(resourceGroupName) ? resourceGroupName : '${abbrs.resourcesResourceGroups}${environmentName}'
  location: location
  tags: tags
}

resource redisEnterpriseResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = if (!empty(redisEnterpriseResourceGroupName)) {
  name: !empty(redisEnterpriseResourceGroupName) ? redisEnterpriseResourceGroupName : resourceGroup.name
}

module redisEnterprise 'core/redis/enterprise.bicep' = {
  scope: redisEnterpriseResourceGroup
  name: 'redis-enterprise'
  params: {
    name: !empty(redisEnterpriseName) ? redisEnterpriseName : '${abbrs.redisEnterprise}${resourceToken}'
    location: redisEnterpriseResourceGroupLocation
    tags: tags
  }
}

output AZURE_LOCATION string = location
output AZURE_TENANT_ID string = tenant().tenantId
output AZURE_RESOURCE_GROUP string = resourceGroup.name

output AZURE_REDIS_ENTERPRISE_RESOURCE_GROUP string = redisEnterpriseResourceGroup.name
