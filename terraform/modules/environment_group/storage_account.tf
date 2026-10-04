###############################################################################
#  MODULE environment_group — Storage Account + Blob Container + Private Endpoint
###############################################################################

# ─── Random suffix for globally unique name ───────────────────────────────────

resource "random_integer" "storage_suffix" {
  min = 1000
  max = 9999
}

# ─── Storage Account ──────────────────────────────────────────────────────────

resource "azurerm_storage_account" "main" {
  name                = "${var.storage_account_prefix}${random_integer.storage_suffix.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
  access_tier              = var.storage_account_access_tier

  # ─── Security ──────────────────────────────────────────────────────────────
  min_tls_version                 = var.storage_min_tls_version
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true

  # Allow public access only from the deployer IP during terraform apply
  public_network_access_enabled = true

  # Firewall: deployer IP only + Azure trusted services
  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = [var.deployer_ip]
  }

  tags = var.tags
}

# ─── Blob Container ───────────────────────────────────────────────────────────

resource "azurerm_storage_container" "documentos" {
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}

# ─── Private DNS Zone for Storage Blob ────────────────────────────────────────

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "link-blob"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = azurerm_virtual_network.main.id
  registration_enabled  = false
  tags                  = var.tags
}

# ─── Private Endpoint for Storage Account ─────────────────────────────────────

resource "azurerm_private_endpoint" "blob" {
  name                = "pe-${azurerm_storage_account.main.name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = azurerm_subnet.private_endpoint.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_storage_account.main.name}"
    private_connection_resource_id = azurerm_storage_account.main.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "dns-zone-group-blob"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }
}
