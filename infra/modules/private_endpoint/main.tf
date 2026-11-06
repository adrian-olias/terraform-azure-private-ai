resource "azurerm_private_endpoint" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = coalesce(var.network_interface_name, "${var.name}-nic")
  tags                          = var.tags

  private_service_connection {
    name                           = var.name
    private_connection_resource_id = var.resource_id
    subresource_names              = [var.subresource]
    is_manual_connection           = false
  }

  # Registers the endpoint's private IP in the private DNS zone
  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}
