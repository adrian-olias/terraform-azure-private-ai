###############################################################################
#  MODULE environment_group — Key Vault + Private Endpoint
###############################################################################

# ─── Data: current tenant and object ID ───────────────────────────────────────

data "azurerm_client_config" "current" {}

# ─── Key Vault ────────────────────────────────────────────────────────────────

resource "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku

  # Security
  purge_protection_enabled   = var.key_vault_purge_protection
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days

  # Allow public access only from the deployer IP during terraform apply
  public_network_access_enabled = true

  # RBAC for access management (recommended over legacy Access Policies)
  rbac_authorization_enabled = true

  # Firewall: deployer IP only + Azure trusted services
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = [var.deployer_ip]
  }

  tags = var.tags
}

# ─── RBAC: current user → Key Vault Administrator ─────────────────────────────

resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

# ─── RBAC: VM → Key Vault Secrets User ───────────────────────────────────────

resource "azurerm_role_assignment" "vm_kv_secrets_user" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_virtual_machine.ai_engine.identity[0].principal_id

  depends_on = [
    azurerm_linux_virtual_machine.ai_engine
  ]
}

# ─── Private DNS Zone for Key Vault ───────────────────────────────────────────

resource "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv" {
  name                  = "link-kv"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.kv.name
  virtual_network_id    = azurerm_virtual_network.main.id
  registration_enabled  = false
  tags                  = var.tags
}

# ─── Private Endpoint for Key Vault ───────────────────────────────────────────

resource "azurerm_private_endpoint" "kv" {
  name                = "pe-${var.key_vault_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = azurerm_subnet.private_endpoint.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${var.key_vault_name}"
    private_connection_resource_id = azurerm_key_vault.main.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "dns-zone-group-kv"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv.id]
  }
}
