# ─── Resource Group for state ─────────────────────────────────────────────────

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# ─── Storage Account (remote state) ──────────────────────────────────────────

resource "azurerm_storage_account" "sa" {
  name                = var.storage_account_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  # LRS = minimum cost for state storage
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  # ─── Security ──────────────────────────────────────────────────────────────
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  # Blob versioning to recover previous states if needed
  blob_properties {
    versioning_enabled = true
  }

  tags = var.tags
}

# ─── Container for .tfstate files ────────────────────────────────────────────

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

# ─── Outputs ──────────────────────────────────────────────────────────────────

output "backend_config" {
  description = "Copy this configuration into manifests/environment/lab/provider.tf"
  value       = <<-EOT

    ╔══════════════════════════════════════════════════════════════════╗
    ║  Copy this block into manifests/environment/lab/provider.tf     ║
    ╠══════════════════════════════════════════════════════════════════╣

      backend "azurerm" {
        resource_group_name  = "${azurerm_resource_group.rg.name}"
        storage_account_name = "${azurerm_storage_account.sa.name}"
        container_name       = "${azurerm_storage_container.container.name}"
        key                  = "lab.terraform.tfstate"
      }

    ╚══════════════════════════════════════════════════════════════════╝
  EOT
}
