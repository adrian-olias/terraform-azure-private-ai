###############################################################################
#  MODULE environment_group — Azure Container Registry (Basic SKU)
#
#  SKU Basic = minimum cost. Does not support Private Endpoint.
#  Security: admin disabled, access only via Managed Identity (AcrPull).
###############################################################################

# ─── Azure Container Registry ─────────────────────────────────────────────────

resource "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = var.acr_sku
  admin_enabled       = false

  tags = var.tags
}

# ─── RBAC: VM → AcrPull ───────────────────────────────────────────────────────

resource "azurerm_role_assignment" "vm_acr_pull" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_virtual_machine.ai_engine.identity[0].principal_id

  depends_on = [
    azurerm_linux_virtual_machine.ai_engine
  ]
}
