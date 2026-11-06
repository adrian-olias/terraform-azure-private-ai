# name (same as the key) is the prefix: Azure needs a globally unique name, so the random suffix is appended
container_registries = {
  crprivateailab = {
    name               = "crprivateailab"
    resource_group_key = "rg-privateai-lab"
    admin_enabled      = false
    sku                = "Basic" # no private endpoint on Basic. Premium in production
  }
}
