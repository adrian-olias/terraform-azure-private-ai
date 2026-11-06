output "id" {
  description = "Network interface ID."
  value       = azurerm_network_interface.this.id
}

output "private_ip_address" {
  description = "Private IP assigned to the interface."
  value       = azurerm_network_interface.this.private_ip_address
}
