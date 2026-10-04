###############################################################################
#  MODULE environment_group — Outputs
###############################################################################

output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.main.name
}

output "vnet_name" {
  description = "VNet name"
  value       = azurerm_virtual_network.main.name
}

output "subnet_id" {
  description = "VM Subnet ID"
  value       = azurerm_subnet.compute.id
}

output "subnet_pe_id" {
  description = "Private Endpoint Subnet ID"
  value       = azurerm_subnet.private_endpoint.id
}

output "nsg_name" {
  description = "NSG name"
  value       = azurerm_network_security_group.main.name
}

output "storage_account_name" {
  description = "Storage Account name"
  value       = azurerm_storage_account.main.name
}

output "storage_container_name" {
  description = "Blob container name"
  value       = azurerm_storage_container.documentos.name
}

# ─── ACR ──────────────────────────────────────────────────────────────────────

output "acr_name" {
  description = "Azure Container Registry name"
  value       = azurerm_container_registry.main.name
}

output "acr_login_server" {
  description = "ACR Login Server"
  value       = azurerm_container_registry.main.login_server
}

output "acr_id" {
  description = "ACR resource ID"
  value       = azurerm_container_registry.main.id
}

# ─── Key Vault ────────────────────────────────────────────────────────────────

output "key_vault_name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.main.name
}

output "key_vault_id" {
  description = "Key Vault resource ID"
  value       = azurerm_key_vault.main.id
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.main.vault_uri
}

# ─── VM ───────────────────────────────────────────────────────────────────────

output "vm_name" {
  description = "VM name"
  value       = azurerm_linux_virtual_machine.ai_engine.name
}

output "vm_managed_identity_principal_id" {
  description = "Managed Identity Principal ID"
  value       = azurerm_linux_virtual_machine.ai_engine.identity[0].principal_id
}

# ─── GitHub Actions Service Principal ─────────────────────────────────────────

output "github_client_id" {
  description = "ACR_USERNAME for GitHub Actions (SP Client ID)"
  value       = azuread_application.github_actions.client_id
}

output "github_client_secret" {
  description = "ACR_PASSWORD for GitHub Actions (SP Client Secret)"
  value       = azuread_service_principal_password.github_actions.value
  sensitive   = true
}
