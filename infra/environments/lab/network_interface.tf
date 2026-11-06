module "network_interface" {
  source   = "../../modules/network_interface"
  for_each = var.network_interfaces

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  location            = local.location
  subnet_id           = module.subnet[each.value.subnet_key].id
  private_ip_address  = each.value.private_ip_address
  tags                = merge(local.tags, each.value.tags)
}

variable "network_interfaces" {
  type = map(object({
    name               = string
    resource_group_key = string
    subnet_key         = string
    private_ip_address = optional(string) # null = dynamic
    tags               = optional(map(string), {})
  }))
}
