output "id" {
  description = "Private DNS zone ID."
  value       = azurerm_private_dns_zone.this.id
}

output "name" {
  description = "Private DNS zone name."
  value       = azurerm_private_dns_zone.this.name
}

output "resource_group_name" {
  description = "Resource group of the private DNS zone."
  value       = azurerm_private_dns_zone.this.resource_group_name
}
