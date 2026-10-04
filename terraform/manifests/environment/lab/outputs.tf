###############################################################################
#  MANIFESTS — Outputs
###############################################################################

output "resource_group_name" {
  description = "Resource Group name"
  value       = module.environment_group.resource_group_name
}

output "vnet_name" {
  description = "VNet name"
  value       = module.environment_group.vnet_name
}

output "subnet_id" {
  description = "VM Subnet ID"
  value       = module.environment_group.subnet_id
}

output "subnet_pe_id" {
  description = "Private Endpoint Subnet ID"
  value       = module.environment_group.subnet_pe_id
}

output "nsg_name" {
  description = "NSG name"
  value       = module.environment_group.nsg_name
}

output "storage_account_name" {
  description = "Storage Account name"
  value       = module.environment_group.storage_account_name
}

# ─── ACR ──────────────────────────────────────────────────────────────────────

output "acr_name" {
  description = "Azure Container Registry name"
  value       = module.environment_group.acr_name
}

output "acr_login_server" {
  description = "ACR Login Server"
  value       = module.environment_group.acr_login_server
}

# ─── Key Vault ────────────────────────────────────────────────────────────────

output "key_vault_name" {
  description = "Key Vault name"
  value       = module.environment_group.key_vault_name
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = module.environment_group.key_vault_uri
}

# ─── VM ───────────────────────────────────────────────────────────────────────

output "vm_name" {
  description = "VM name"
  value       = module.environment_group.vm_name
}

# ─── GitHub Actions SP (copy to GitHub Secrets) ───────────────────────────────

output "github_client_id" {
  description = "Copy this as ACR_USERNAME in GitHub Actions"
  value       = module.environment_group.github_client_id
}

output "github_client_secret" {
  description = "Copy this as ACR_PASSWORD in GitHub Actions"
  value       = module.environment_group.github_client_secret
  sensitive   = true
}
