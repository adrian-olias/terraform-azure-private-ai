output "id" {
  description = "Container registry ID."
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "Container registry name."
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "Login server, e.g. crprivateai1234.azurecr.io."
  value       = azurerm_container_registry.this.login_server
}
