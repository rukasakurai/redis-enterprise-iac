param name string
param location string

param sku object = {
  name: 'Enterprise_E10'
  capacity: 2
}

resource redisEnterprise 'Microsoft.Cache/redisEnterprise@2021-03-01' = {
  name: name
  location: location
  sku: sku
  properties: {
    minimumTlsVersion: '1.2'
  }
}

output id string = redisEnterprise.id
