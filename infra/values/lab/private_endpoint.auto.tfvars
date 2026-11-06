private_endpoints = {
  pe-privateai-lab-storage = {
    name                 = "pe-privateai-lab-storage"
    resource_group_key   = "rg-privateai-lab"
    subnet_key           = "snet-endpoints"
    target_type          = "storage_account"
    target_key           = "stprivateailab"
    subresource          = "blob"
    private_dns_zone_key = "privatelink.blob.core.windows.net"
  }

  pe-privateai-lab-keyvault = {
    name                 = "pe-privateai-lab-keyvault"
    resource_group_key   = "rg-privateai-lab"
    subnet_key           = "snet-endpoints"
    target_type          = "key_vault"
    target_key           = "kv-privateai-lab"
    subresource          = "vault"
    private_dns_zone_key = "privatelink.vaultcore.azure.net"
  }
}
