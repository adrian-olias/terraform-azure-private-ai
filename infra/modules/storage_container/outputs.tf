output "id" {
  description = "Container ID."
  value       = azurerm_storage_container.this.id
}

output "name" {
  description = "Container name."
  value       = azurerm_storage_container.this.name
}
