module "private_dns_zone_vnet_link" {
  source   = "../../modules/private_dns_zone_vnet_link"
  for_each = var.private_dns_zone_vnet_links

  name                  = each.value.name
  resource_group_name   = module.private_dns_zone[each.value.private_dns_zone_key].resource_group_name
  private_dns_zone_name = module.private_dns_zone[each.value.private_dns_zone_key].name
  virtual_network_id    = module.virtual_network[each.value.virtual_network_key].id
  registration_enabled  = each.value.registration_enabled
  tags                  = merge(local.tags, each.value.tags)
}

variable "private_dns_zone_vnet_links" {
  type = map(object({
    name                 = string
    private_dns_zone_key = string
    virtual_network_key  = string
    registration_enabled = bool
    tags                 = optional(map(string), {})
  }))
}
