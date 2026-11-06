module "network_security_group" {
  source   = "../../modules/network_security_group"
  for_each = var.network_security_groups

  name = each.value.name

  resource_group_name       = module.resource_group[each.value.resource_group_key].name
  location                  = local.location
  deny_all_inbound_priority = each.value.deny_all_inbound_priority

  tags = merge(local.tags, each.value.tags)

  # A rule names its source either as a CIDR or as the key of a subnet, whose CIDR is read from the subnet
  inbound_rules = {
    for rule in values(each.value.inbound_rules) : rule.name => {
      priority                   = rule.priority
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      source_address_prefix      = rule.source_subnet_key != null ? module.subnet[rule.source_subnet_key].address_prefix : rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix
      destination_port_range     = rule.destination_port_range
    }
  }
}

variable "network_security_groups" {
  type = map(object({
    name                      = string
    resource_group_key        = string
    deny_all_inbound_priority = number

    tags = optional(map(string), {})

    inbound_rules = map(object({
      name                       = string
      priority                   = number
      protocol                   = string
      source_port_range          = string
      destination_address_prefix = string
      destination_port_range     = string
      source_address_prefix      = optional(string)
      source_subnet_key          = optional(string)
    }))
  }))
}
