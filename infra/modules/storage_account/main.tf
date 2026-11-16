resource "azurerm_storage_account" "this" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_kind                    = var.account_kind
  account_tier                    = var.account_tier
  account_replication_type        = var.replication_type
  shared_access_key_enabled       = var.shared_access_key_enabled
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  min_tls_version                 = var.min_tls_version
  tags                            = var.tags

  # Guardrail: workloads use the private endpoint. The public endpoint stays off unless operator IPs
  # are listed, and even then it denies everything except those IPs
  public_network_access = length(var.allowed_ips) > 0 ? "Enabled" : "Disabled"

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = var.allowed_ips
  }
}

