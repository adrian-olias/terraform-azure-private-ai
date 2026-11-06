# Resources a private endpoint can expose, by type and key
locals {
  private_endpoint_targets = {
    storage_account = { for key, m in module.storage_account : key => m.id }
    key_vault       = { for key, m in module.key_vault : key => m.id }
  }
}

module "private_endpoint" {
  source   = "../../modules/private_endpoint"
  for_each = var.private_endpoints

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  location            = local.location
  subnet_id           = module.subnet[each.value.subnet_key].id
  resource_id         = local.private_endpoint_targets[each.value.target_type][each.value.target_key]
  subresource         = each.value.subresource
  private_dns_zone_id = module.private_dns_zone[each.value.private_dns_zone_key].id
  tags                = merge(local.tags, each.value.tags)
}

variable "private_endpoints" {
  type = map(object({
    name                 = string
    resource_group_key   = string
    subnet_key           = string
    target_type          = string
    target_key           = string
    subresource          = string
    private_dns_zone_key = string
    tags                 = optional(map(string), {})
  }))
}
