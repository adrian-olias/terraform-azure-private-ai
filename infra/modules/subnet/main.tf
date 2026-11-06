resource "azurerm_subnet" "this" {
  name                              = var.name
  resource_group_name               = var.resource_group_name
  virtual_network_name              = var.virtual_network_name
  address_prefixes                  = [var.address_prefix]
  default_outbound_access_enabled   = var.default_outbound_access_enabled
  private_endpoint_network_policies = var.private_endpoint_network_policies
}
