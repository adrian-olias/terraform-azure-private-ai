resource "azurerm_key_vault" "this" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  rbac_authorization_enabled = var.rbac_authorization_enabled
  tags                       = var.tags

  # Guardrail: workloads use the private endpoint. The public endpoint stays off unless operator IPs
  # are listed, and even then it denies everything except those IPs
  public_network_access_enabled = length(var.allowed_ips) > 0

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = var.allowed_ips
  }
}
