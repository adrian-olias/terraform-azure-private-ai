output "id" {
  description = "VM ID."
  value       = azurerm_linux_virtual_machine.this.id
}

output "name" {
  description = "VM name."
  value       = azurerm_linux_virtual_machine.this.name
}

output "principal_id" {
  description = "Managed identity principal ID, for role assignments."
  value       = azurerm_linux_virtual_machine.this.identity[0].principal_id
}
