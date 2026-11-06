output "id" {
  description = "Subnet ID."
  value       = azurerm_subnet.this.id
}

output "name" {
  description = "Subnet name."
  value       = azurerm_subnet.this.name
}

output "address_prefix" {
  description = "Subnet CIDR."
  value       = azurerm_subnet.this.address_prefixes[0]
}
