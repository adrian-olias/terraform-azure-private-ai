# name (same as the key) is the prefix: Azure needs a globally unique name, so the random suffix is appended
storage_accounts = {
  stprivateailab = {
    name                            = "stprivateailab"
    resource_group_key              = "rg-privateai-lab"
    public_network_access_enabled   = false
    shared_access_key_enabled       = false
    allow_nested_items_to_be_public = false
    min_tls_version                 = "TLS1_2"
    account_kind                    = "StorageV2"
    account_tier                    = "Standard"
    replication_type                = "LRS"
  }
}
