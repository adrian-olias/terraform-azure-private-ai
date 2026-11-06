module "storage_account" {
  source   = "../../modules/storage_account"
  for_each = var.storage_accounts

  name                            = "${each.value.name}${random_string.suffix.result}"
  resource_group_name             = module.resource_group[each.value.resource_group_key].name
  location                        = local.location
  public_network_access_enabled   = each.value.public_network_access_enabled
  shared_access_key_enabled       = each.value.shared_access_key_enabled
  allow_nested_items_to_be_public = each.value.allow_nested_items_to_be_public
  min_tls_version                 = each.value.min_tls_version
  account_kind                    = each.value.account_kind
  account_tier                    = each.value.account_tier
  replication_type                = each.value.replication_type
  tags                            = merge(local.tags, each.value.tags)
}

variable "storage_accounts" {
  type = map(object({
    name                            = string
    resource_group_key              = string
    public_network_access_enabled   = bool
    shared_access_key_enabled       = bool
    allow_nested_items_to_be_public = bool
    min_tls_version                 = string
    account_kind                    = string
    account_tier                    = string
    replication_type                = string
    tags                            = optional(map(string), {})
  }))
}
