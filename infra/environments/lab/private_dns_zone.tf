module "private_dns_zone" {
  source   = "../../modules/private_dns_zone"
  for_each = var.private_dns_zones

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  tags                = merge(local.tags, each.value.tags)
}

variable "private_dns_zones" {
  type = map(object({
    name               = string
    resource_group_key = string
    tags               = optional(map(string), {})
  }))
}
