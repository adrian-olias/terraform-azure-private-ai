module "virtual_network" {
  source   = "../../modules/virtual_network"
  for_each = var.virtual_networks

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  location            = local.location
  address_space       = each.value.address_space
  tags                = merge(local.tags, each.value.tags)
}

variable "virtual_networks" {
  type = map(object({
    name               = string
    resource_group_key = string
    address_space      = list(string)
    tags               = optional(map(string), {})
  }))
}
