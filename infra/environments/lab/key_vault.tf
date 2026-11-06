module "key_vault" {
  source   = "../../modules/key_vault"
  for_each = var.key_vaults

  name                          = "${each.value.name}-${random_string.suffix.result}"
  resource_group_name           = module.resource_group[each.value.resource_group_key].name
  location                      = local.location
  rbac_authorization_enabled    = each.value.rbac_authorization_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = each.value.sku_name
  purge_protection_enabled      = each.value.purge_protection_enabled
  soft_delete_retention_days    = each.value.soft_delete_retention_days
  tags                          = merge(local.tags, each.value.tags)
}

variable "key_vaults" {
  type = map(object({
    name                          = string
    resource_group_key            = string
    rbac_authorization_enabled    = bool
    public_network_access_enabled = bool
    sku_name                      = string
    purge_protection_enabled      = bool
    soft_delete_retention_days    = number
    tags                          = optional(map(string), {})
  }))
}
