module "subnet" {
  source   = "../../modules/subnet"
  for_each = var.subnets

  name                              = each.value.name
  resource_group_name               = module.virtual_network[each.value.virtual_network_key].resource_group_name
  virtual_network_name              = module.virtual_network[each.value.virtual_network_key].name
  address_prefix                    = each.value.address_prefix
  default_outbound_access_enabled   = each.value.default_outbound_access_enabled
  private_endpoint_network_policies = each.value.private_endpoint_network_policies
}

variable "subnets" {
  type = map(object({
    name                              = string
    virtual_network_key               = string
    address_prefix                    = string
    default_outbound_access_enabled   = bool
    private_endpoint_network_policies = string
  }))
}
