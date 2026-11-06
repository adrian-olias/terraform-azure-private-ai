output "id" {
  description = "Virtual network ID."
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "Virtual network name."
  value       = azurerm_virtual_network.this.name
}

output "resource_group_name" {
  description = "Resource group of the virtual network."
  value       = azurerm_virtual_network.this.resource_group_name
}
