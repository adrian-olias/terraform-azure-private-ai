# name (same as the key) is the prefix: Azure needs a globally unique name, so -<random suffix> is appended
key_vaults = {
  kv-privateai-lab = {
    name                          = "kv-privateai-lab"
    resource_group_key            = "rg-privateai-lab"
    rbac_authorization_enabled    = true
    public_network_access_enabled = false
    sku_name                      = "standard"
    purge_protection_enabled      = false # lab: easy to destroy and recreate
    soft_delete_retention_days    = 7
  }
}
